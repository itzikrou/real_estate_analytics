class AddExtrasToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :extras, :string
  end
end
