class PropertiesController < ApplicationController

  def index    
    @q = Property.ransack(params[:q])
    # @properties = @q.result(distinct: true)
    # @properties.order(print_date: :desc)
    # @res = @properties.last(100)   
    @properties = @q.result.paginate(page: params[:page], per_page: params[:per_page])
    # render json: {properties: @properties}
  end


  # @rooms = @search.result.paginate(page: params[:page], per_page: params[:per_page])
 
  # def show    
  #   @properties = Propert.find(params[:id])
  # end

  def show
    @properties = Property.find(params[:id])
  end

end
