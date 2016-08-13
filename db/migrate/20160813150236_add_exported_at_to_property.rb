class AddExportedAtToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :exported_at, :datetime
  end
end
