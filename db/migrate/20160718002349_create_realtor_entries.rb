class CreateRealtorEntries < ActiveRecord::Migration
  def change
    create_table :realtor_entries do |t|
      t.jsonb :data
      t.string :mls_id

      t.timestamps null: false
    end
  end
end
