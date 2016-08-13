class AddExportedAtToRealtorEntry < ActiveRecord::Migration
  def change
    add_column :realtor_entries, :exported_at, :datetime
  end
end
