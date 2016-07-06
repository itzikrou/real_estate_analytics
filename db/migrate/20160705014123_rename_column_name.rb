class RenameColumnName < ActiveRecord::Migration
  def change
    rename_column :properties, :longtitude, :longitude
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
