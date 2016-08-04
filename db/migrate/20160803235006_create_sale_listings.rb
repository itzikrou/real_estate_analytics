class CreateSaleListings < ActiveRecord::Migration
  def change
    create_table :sale_listings do |t|
      t.string    :mls_id, null: false
      
      t.integer   :status
      t.datetime  :list_date
      t.datetime  :sold_date
      t.datetime  :last_fetched_status
      t.integer   :days_on_market
      t.float     :expected_return_rate

      t.integer   :asking_price
      t.integer   :closing_price
      t.integer   :taxes

      t.string    :address
      t.string    :postal
      t.float     :longitude
      t.float     :latitude

      t.integer :home_type
      t.integer :home_style
      t.integer :rooms_total
      t.integer :family_rooms
      t.integer :bedrooms
      t.integer :washrooms
      t.integer :kitchens

      t.integer :basement_type
      t.integer :basement_rooms
      t.integer :basement_bedrooms
      t.integer :basement_washrooms
      t.integer :basement_kitchens

      t.string  :heat_type
      t.string  :air_conditioner
      t.float   :sqft_from
      t.float   :sqft_to
      t.integer :num_of_stories

      t.integer :parking_spaces
      t.string  :garage
      t.float   :lot_length
      t.float   :lot_width
      t.string  :apx_age
      t.string  :ammenities
      t.string  :pool
      t.string  :water
      t.string  :sewer
      t.string  :exterior

      t.string :ammenities_near_by
      t.string :cross_streets
      t.text   :remarks
      t.text   :extras

      t.jsonb  :raw_data

      t.timestamps null: false
    end
  end
end