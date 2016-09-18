json.extract! @realtor_entry, :id, :data, :mls_id, :created_at, :updated_at, :exported_at
json.url realtor_entries_url(@realtor_entry, format: :json)


