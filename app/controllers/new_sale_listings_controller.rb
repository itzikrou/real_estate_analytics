class NewSaleListingsController < BaseModelController
  model SaleListing
  filter_by [:id, :mls_id, :status, :list_date, :sold_date,
             :last_fetched_status, :days_on_market, :expected_return_rate,
             :asking_price, :closing_price, :taxes, :address, :postal,
             :longitude, :latitude, :home_type, :home_style, :rooms_total,
             :family_rooms, :bedrooms, :washrooms, :kitchens, :basement_type,
             :basement_rooms, :basement_bedrooms, :basement_washrooms,
             :basement_kitchens, :heat_type, :air_conditioner, :sqft_from,
             :sqft_to, :num_of_stories, :parking_spaces, :garage, :lot_length,
             :lot_width, :apx_age, :ammenities, :pool, :water, :sewer, :exterior,
             :ammenities_near_by, :cross_streets, :remarks, :extras, :raw_data,
             :created_at, :updated_at]

  def index
    @objects = model.all
    if params[:lat] && params[:lng]
      dist = params[:dist].present? ? Integer(params[:dist]) : 2
      @objects = @objects.where_near_by(params[:lat], params[:lng], dist=dist)
    end
    if params[:price_from]
      @objects = @objects.where 'asking_price >= ?', params[:price_from]
    end
    if params[:price_to]
      @objects = @objects.where 'asking_price <= ?', params[:price_to]
    end

    super
  end
end
