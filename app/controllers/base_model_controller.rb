class BaseModelController < ApplicationController
  include Pageable

  class << self
    attr_accessor :model_value, :filter_by_value, :include_relations_value, :order_by_value

    protected

    def model(model)
      @model_value = model
    end

    def filter_by(filter_by)
      @filter_by_value = filter_by
    end

    def order_by(order_by)
      @order_by_value = order_by
    end

    def include_relations(include_relations)
      @include_relations_value = include_relations
    end
  end

  counted_by :count, default: 25, max: 250

  def self.inherited(subclass)
    %w(default_count min_count max_count default_page min_page max_page).each do |field|
      subclass.instance_variable_set("@#{field}", instance_variable_get("@#{field}"))
    end
  end

  # get list
  def index
    @objects ||= model.all
    apply_filters
    instance_variable_set("@#{modal_name_plural}", @objects)
    create_response(true)
  end

  # get detail
  def show
    @objects ||= model.where(id: params[:id])
    instance_variable_set("@#{modal_name_singular}", @objects.first)
    create_response
  end

  # TODO: add write methods
  # post list
  def create
  end

  # put / patch detail
  def update
  end

  # delete detail
  def destroy
  end

  protected

  def model
    raise 'Model not defined by child class' if self.class.model_value.nil?
    self.class.model_value
  end

  def filter_by
    self.class.filter_by_value || []
  end

  def order_by
    self.class.order_by_value || []
  end

  def include_relations
    self.class.include_relations_value || []
  end

  private

  def base_response
    {
        meta: {
            page: nil,
            count: nil,
            total: nil
        }
    }.clone
  end

  def modal_name_singular
    model.model_name.singular
  end

  def modal_name_plural
    model.model_name.plural
  end

  @objects = nil

  def apply_filters(object = @objects)
    object.reveal(filter_by).filter(params)
  end

  def apply_ordering(object = @objects)
    # default order by for the models
    if params[:sort].present? && (JSON.parse(params[:sort]) rescue {}).present?
      object.order(JSON.parse(params[:sort]))
    elsif order_by.present?
      object.order(*order_by)
    else
      object
    end
  end

  def create_response(is_plural = false)
    @objects = @objects.includes(*include_relations) if include_relations.present?
    if is_plural
      add_paging_and_ordering
      create_json_response
    else
      create_json_response_singular
    end
  end

  def add_paging_and_ordering
    @objects = apply_ordering(@objects).page(page).per_page(count)
  end

  def create_json_response
    response = base_response
    response[modal_name_plural] = @objects
    response[:meta][:page] = page
    response[:meta][:count] = count
    response[:meta][:total] = apply_filters(model.all).count # TODO: this could be cached
    render json: response.to_json(include: include_relations)
  end

  def create_json_response_singular
    response = base_response
    response[modal_name_singular] = @objects.first
    response.delete(:meta)
    render json: response.to_json(include: include_relations)
  end
end
