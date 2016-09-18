json.array!(@realtor_entries) do |entry|
  json.extract! entry, :id, :data, :mls_id, :created_at, :updated_at, :exported_at
  json.url realtor_entries_url(entry, format: :json)

end