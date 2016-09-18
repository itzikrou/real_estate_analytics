json.extract! @properties, :id, :mls_id, :for, :address, :street_name,
              :street_number, :longitude, :latitude, :listing_status,
              :municipality, :home_type, :home_style, :apt_unit,
              :bedrooms, :washrooms, :kitchens, :sqft_from, :sqft_to,
              :basement, :fronting_on, :family_rooms, :heat_type,
              :air_conditioner, :exterior, :drive, :garage, :parking_spaces,
              :water, :sewer, :lot, :lot_length, :lot_width, :rooms, :pool,
              :cross_streets, :last_status, :list_price, :leased_price, :sale_price,
              :leased_date, :sold_date, :postal, :listing_type, :dom, :taxes,
              :client_remarks, :images_links, :print_date, :created_at, :updated_at,
              :extras, :apx_age, :apx_sqft, :parsed_data, :basement_bedrooms,
              :basement_washrooms, :basement_kitchens, :total_rooms, :basement_rooms,
              :expected_return_rate, :exported_at

json.url properties_url(@properties, format: :json)


