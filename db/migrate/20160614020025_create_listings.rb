class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
    	t.text :raw_email

      t.timestamps null: false
    end
  end
end
