json.extract! @sale_listings, :id, :mls_id, :status, :list_date, :sold_date, :last_fetched_status,
              :days_on_market, :expected_return_rate, :asking_price, :closing_price, :taxes,
              :address, :postal, :longitude, :latitude, :home_type, :home_style, :rooms_total,
              :family_rooms, :bedrooms, :washrooms, :kitchens, :basement_type, :basement_rooms,
              :basement_bedrooms, :basement_washrooms, :basement_kitchens, :heat_type, :air_conditioner,
              :sqft_from, :sqft_to, :num_of_stories, :parking_spaces, :garage, :lot_length, :lot_width,
              :apx_age, :ammenities, :pool, :water, :sewer, :exterior, :ammenities_near_by, :cross_streets,
              :remarks, :extras, :raw_data, :created_at, :updated_at

json.url sale_listings_url(@sale_listings, format: :json)


