class AddBasementWashroomBedroomToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :basement_bedrooms, :integer
    add_column :properties, :basement_washrooms, :integer
  end
end
