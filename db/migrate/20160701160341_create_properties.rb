class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string  :mls_id
      t.string  :for
      t.string  :address
      t.string  :street_name
      t.string  :street_number
      t.float   :longtitude
      t.float   :latitude
      t.string  :listing_status
      t.string  :municipality
      t.string  :home_type
      t.string  :home_style
      t.string  :apt_unit
      t.integer :bedrooms
      t.integer :washrooms
      t.integer :kitchens
      t.integer :sqft_from
      t.integer :sqft_to
      t.string  :basement
      t.string  :fronting_on
      t.integer :family_rooms
      t.string  :heat_type
      t.string  :air_conditioner
      t.string  :exterior
      t.string  :drive
      t.string  :garage
      t.integer :parking_spaces
      t.string  :water
      t.string  :sewer
      t.float   :lot_length
      t.float   :lot_width
      t.integer :rooms
      t.string  :pool
      t.string  :cross_streets
      t.string  :last_status
      t.integer :list_price
      t.integer :leased_price
      t.integer :sale_price
      t.string  :postal
      t.string  :listing_type
      t.integer :dom
      t.integer :taxes
      t.text    :client_remarks
      t.jsonb   :images_links
      t.datetime  :print_date     

      t.timestamps null: false
    end
  end
end
