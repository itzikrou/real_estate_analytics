class AddBasementKitchensAndTotalRoomsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :basement_kitchens, :integer
    add_column :properties, :total_rooms, :integer
    add_column :properties, :basement_rooms, :integer
  end
end
