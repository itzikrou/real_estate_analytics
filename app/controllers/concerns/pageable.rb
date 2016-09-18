module Pageable
  extend ActiveSupport::Concern

  included do
    def self.default_count
      @default_count.nil? ? 10 : @default_count
    end

    def self.default_count=(value)
      @default_count = value || 10
    end

    def self.max_count
      @max_count.nil? ? 100 : @max_count
    end

    def self.min_count
      @min_count.nil? ? 1 : @min_count
    end

    def self.counted_by(name, options = {})
      @counted_name = name.to_s

      if options.present?
        @default_count = options[:default].to_i if options.key? :default
        @min_count = options[:min].to_i if options.key? :min
        @max_count = options[:max].to_i if options.key? :max
      end
    end

    def self.counted_name
      @counted_name || :count
    end

    def self.default_page
      @default_page.nil? ? 1 : @default_page
    end

    def self.max_page
      @max_page.nil? ? 100 : @max_page
    end

    def self.min_page
      @min_page.nil? ? 1 : @min_page
    end

    def self.paged_by(name, options = {})
      @paged_name = name.to_s

      if options.present?
        @default_page = options[:default].to_i if options.key? :default
        @min_page = options[:min].to_i if options.key? :min
        @max_page = options[:max].to_i if options.key? :max
      end
    end

    def self.paged_name
      @paged_name || :page
    end
  end

  protected

  def count
    clazz = self.class

    @count ||= [
        clazz.min_count,
        (params[clazz.counted_name] || clazz.default_count).to_i,
        clazz.max_count
    ].sort[1]
  end

  def page
    clazz = self.class

    @page ||= [
        clazz.min_page,
        (params[clazz.paged_name] || clazz.default_page).to_i,
        clazz.max_page
    ].sort[1]
  end
end