class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
    	t.string 	:mls_id
    	t.string	:address
    	t.string	:municipality
    	t.string	:apt_unit
    	t.integer	:beds
    	t.integer	:wr
    	t.string	:lsc
    	t.integer	:list_price
    	t.integer	:sale_price
    	t.string	:postal
    	t.string	:listing_type
    	t.integer	:dom
    	t.integer	:taxes
    	t.text		:client_remarks

      t.timestamps null: false
    end
  end
end
