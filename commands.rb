while true do Property.all.sample.fetch_current_nearby end
RealtorEntry.all.each{|re| RealtorDataAdapter.new(re.data).create_data_entry}