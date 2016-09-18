module AssociatedValidatorExtensions
  def validate_each(record, attribute, value)
    result = super
    if options[:with] == :bubble
      if record.errors[attribute].include? 'is invalid'
        record.errors[attribute].reject! do |error|
          error == 'is invalid'
        end
        bubble_association record, attribute
      end
      if record.errors[attribute].blank?
        record.errors.delete attribute
      end
    end
    result
  end

  def bubble_association(record, attribute)
    association = record.class.reflect_on_association attribute
    if association.collection?
      record.send(attribute).each do |element|
        copy_errors record, element
      end
    else
      copy_errors record, record.send(attribute)
    end
  end

  def copy_errors(record, source)
    source.errors.each do |key, error|
      record.errors.add key, error
    end
  end
end

module ActiveRecord
  module Validations
    class AssociatedValidator
      prepend ::AssociatedValidatorExtensions
    end
  end
  module ConnectionAdapters
    module PostgreSQL
      class TableDefinition
        old_method_missing = instance_method :method_missing

        define_method :method_missing do |method, *args, &block|
          connection = ActiveRecord::Base.connection
          if connection.enum_names.include? method.to_s
            column args[0], method, *(args[1 .. -1])
          else
            old_method_missing.bind(self).call method, *args, &block
          end
        end
      end
    end
    class PostgreSQLAdapter
      old_native_database_types = instance_method :native_database_types

      def enum_names
        enums.map { |enum| enum[1] }
      end

      define_method :native_database_types do
        @native_database_types ||= old_native_database_types.bind(self).call.merge(
            Hash[enum_names.map { |enum| [enum.to_sym, {name: enum}] }]
        )
      end
    end
    class PostgreSQLColumn
      old_type = instance_method :type

      define_method :type do
        (type = old_type.bind(self).call) == :enum ? sql_type.to_sym : type
      end
    end
  end
end

module ActiveRecord
  class DeleteRestrictionError < ActiveRecordError
    attr_reader :name

    def initialize(name = nil)
      if @name = name
        super "Cannot delete record because of dependent #{name}"
      else
        super "Delete restriction error."
      end
    end
  end
end

# - Rummage - #

module ActiveRecord
  class Relation
    module Rummage
      attr_accessor :permitted_fields
      attr_accessor :permitted_assocs

      def allow(*assocs)
        self.permitted_assocs ||= []
        Array(assocs).each do |assoc|
          if assoc.is_a?(String) || assoc.is_a?(Symbol)
            self.permitted_assocs << assoc.to_s
          elsif assoc.is_a?(Array)
            self.allow *assoc
          else
            # Handle invalid input type.
            raise "Cannot allow associations from #{assoc.class.name}"
          end
        end
        self
      end

      def reallow(*fields)
        unallow.reallow *fields
      end

      def unallow
        self.permitted_assocs = nil
        self
      end

      def reveal(*fields)
        self.permitted_fields ||= []
        Array(fields).each do |field|
          if field.is_a?(String) || field.is_a?(Symbol)
            self.permitted_fields << field.to_s
          elsif field.is_a?(Array)
            self.reveal *field
          elsif field.is_a?(Hash)
            # Allow key assocations.
            self.allow field.keys
            # White-list hash contents.
            field.each do |assoc, inner_fields|
              # For hashes, the prefix fields with the singular association name.
              self.permitted_fields += Array(inner_fields).map do |inner_field|
                "#{assoc.to_s.singularize}_#{inner_field.to_s}"
              end
            end
          else
            # Handle invalid input type.
            raise "Cannot reveal fields from #{field.class.name}"
          end
        end
        self
      end

      def rereveal(*fields)
        unstash.stash *fields
      end

      def unreveal
        self.permitted_fields = nil
        self
      end

      def filter(params = {})
        unless params.is_a? Hash
          # Handle invalid parameter types.
          raise "Filter expected a Hash"
        end
        params = params.stringify_keys
        allow_all = in_field_list? '*'
        # Columns local to model are always filtered.
        params.slice(*klass.column_names).each do |field, value|
          params.delete field # Prevent duplicate conditions.
          # The primary key on the model is always allowed.
          if allow_all || field == klass.primary_key || in_field_list?(field)
            filter! klass, field, value
          end
        end
        # Associations require white-list.
        if params.present? && permitted_assocs.present?
          klass.reflect_on_all_associations.each do |assoc|
            # Only white-listed associations are filtered.
            next unless in_assoc_list? assoc.name
            prefix = assoc.plural_name.singularize
            permit = assoc.klass.column_names.map do |name|
              "#{prefix}_#{name}"
            end
            allow_all = in_field_list? "#{prefix}_*"
            # The primary key on an assocation is always allowed.
            if assoc.klass.primary_key.present?
              primary_key = "#{prefix}_#{assoc.klass.primary_key}"
            end
            # Filter using columns on assocation.
            params.slice(*permit).each do |field, value|
              params.delete field # Prevent duplicate conditions.
              if allow_all || field == primary_key || in_field_list?(field)
                field = field[prefix.length + 1 .. field.length]
                joins!(assoc.name.to_sym).filter! assoc.klass, field, value
              end
            end
          end
        end
        self
      end

      protected

      def in_assoc_list?(name)
        return false unless permitted_assocs.present?
        permitted_assocs.reject(&:blank?).map(&:to_s).include? name.to_s
      end

      def in_field_list?(name)
        return false unless permitted_fields.present?
        permitted_fields.reject(&:blank?).map(&:to_s).include? name.to_s
      end

      def filter!(model, field, value)
        table = model.arel_table
        if value.is_a? Hash
          value = value.with_indifferent_access
          type = model.columns_hash[field].type
          if value.key? :not
            # All types can do a negated match.
            if value[:not].is_a? Array
              where! table[field].not_in value[:not]
            else
              where! table[field].not_eq value[:not]
            end
          end
          # Numeric and Time/Date fields can use relation operators.
          if [:decimal, :float, :integer, :time, :date, :datetime].include? type
            # Accept only one-of '>' or '>='
            if value.key? :gt
              where! table[field].gt value[:gt]
            elsif value.key? :gte
              where! table[field].gteq value[:gte]
            end
            # Accept only one-of '<' or '<='
            if value.key? :lt
              where! table[field].lt value[:lt]
            elsif value.key? :lte
              where! table[field].lteq value[:lte]
            end
          end
          # String and Text are able to use LIKE.
          if [:string, :text].include? type
            if value.key? :like
              # Pure like filters have leading and trailing wildcards.
              filters = Array(value[:like]).map { |v| "%#{v}%" }
              where! table[field].matches_any filters
            else
              if value.key? :starts_with
                # Starts-with filters have a trailing wildcard.
                filters = Array(value[:starts_with]).map { |v| "#{v}%" }
                where! table[field].matches_any filters
              end
              if value.key? :ends_with
                # Ends-with filters have a leading wildcard.
                filters = Array(value[:ends_with]).map { |v| "%#{v}" }
                where! table[field].matches_any filters
              end
            end
          end
        else
          if value.is_a? Array
            where! table[field].in value
          else
            where! table[field].eq value
          end
        end
      end
    end
  end
end

class ActiveRecord::Relation
  include Rummage
end

class ActiveRecord::Base
  def self.allow(*fields)
    all.allow *fields
  end

  def self.reveal(*fields)
    all.reveal *fields
  end

  def self.filter(params = {})
    all.filter params
  end
end