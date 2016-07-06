class AddFieldsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :apx_age, :string
    add_column :properties, :apx_sqft, :string
    add_column :properties, :parsed_data, :jsonb
  end
end
