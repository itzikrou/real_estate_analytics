require 'open-uri'

class ListingParser

	def self.parse(url)
		doc = Nokogiri::HTML(open(url)) do |config|
  			config.strict.nonet.noblanks
		end

		Listing.create!(raw_email: doc.to_s)
		arr = []
		doc.css('tbody tr').each do |link| 
			arr << link
		end
		arr.each{ |item|
			extract_single_entry(item)
		}
	end

	def self.extract_single_entry(item)
		hash = Hash.from_xml(item.to_s)
		extra_details 	= JSON.parse(hash["tr"]["data_pop_up"])			
		data_ln 				= hash["tr"]["data_ln"].to_f
		data_lt 				= hash["tr"]["data_lt"].to_f
		data_identifier = hash["tr"]["data_identifier"]
		lp_dol 				= extra_details["lp_dol"].to_i
		type_own1_out	= extra_details["type_own1_out"] # home type [Detached]
		tot_area 			= extra_details["tot_area"]
		tot_areacd		= extra_details["tot_areacd"]
		lsc 					= extra_details["lsc"] # New \ Sld \ Lsd
		addr 					= extra_details["addr"]
		apt_num 			= extra_details["apt_num"]
		ml_num				= extra_details["ml_num"]
		latitude			= extra_details["latitude"].to_f
		longitude			= extra_details["longitude"].to_f
		municipality 	= extra_details["municipality"]
		zip						= extra_details["zip"]
		br						= extra_details["br"].to_i
		bath_tot			= extra_details["bath_tot"]
		style					= extra_details["style"] #1 1/2 Storey \ Bungalow-Raised \ 2-Storey \ Apartment
		raw_data 			= item.to_s


		client_remarks = item.xpath("//*[@id=\"#{ml_num}\"]/div[2]/div[2]/div[1]/div/div[7]/span[1]/span/text()")			
		extras = item.xpath("//*[@id=\"#{ml_num}\"]/div[2]/div[2]/div[1]/div/div[7]/span[2]/span/text()")
		dom = item.xpath("//*[@id=\"#{ml_num}\"]/div[2]/div[2]/div[1]/div/div[1]/div/div[2]/div[4]/div[3]/span/span/text()").to_s
		
		# Taxes
		taxes 	= item.xpath("//*[@id=\"#{ml_num}\"]/div[2]/div[2]/div[1]/div/div[1]/div/div[2]/div[2]/div[1]/div/span[1]/span/text()").to_s
		taxes.slice!('$')
		taxes.slice!(',')

		# lot
		lot = item.xpath("//*[@id=\"#{ml_num}\"]/div[2]/div[2]/div[1]/div/div[1]/div/div[2]/div[4]/div[1]/div[1]/span[3]/span/text()")

		# Street & Number
		white_space_index = addr.index(' ')
		street_name = addr[white_space_index..addr.size].strip
		street_number = addr[0..white_space_index-1].strip

		entry = Entry.find_or_create_by(mls_id: ml_num)
		entry.address = addr
		entry.municipality = municipality
		entry.beds = br
		entry.wr = bath_tot
		entry.lsc = lsc
		entry.list_price = lp_dol
		entry.postal = zip
		entry.address = addr
		entry.address = addr
		entry.client_remarks = client_remarks.to_s + ',' + extras.to_s
		entry.dom = dom.to_i unless dom.blank?
		entry.taxes = taxes
		entry.raw_data = raw_data
		entry.street_name = street_name
		entry.street_number = street_number
		entry.save! 
	end

	def self.bulk_import(file_path)
		line_num=0
		File.open(file_path).each do |line|
		  print "#{line_num += 1} #{line}"
		  parse(line)
		end
	end


end