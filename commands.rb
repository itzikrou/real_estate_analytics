while true do Property.all.sample.fetch_current_nearby ; i = i+1 ; sleep(5) end
RealtorEntry.all.each{|re| RealtorDataAdapter.new(re.data).create_data_entry}

RealtorEntry.all.each{|re| RealtorDataAdapter.new(re.data).create_data_entry}

 i = 0; while i<100 do Property.all.sample.fetch_current_nearby ; i = i+1 ; sleep(2) end

  i = 0; while i<200 do Property.all.sample.fetch_current_nearby ; i = i+1 ; sleep(2) end

  Property.all.each{|p| MlsEmailDataAdapter.new(p.parsed_data).create_data_entry}

  EmailWorker.perform
