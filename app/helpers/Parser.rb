require 'open-uri'

class Parser

	
	def url
		"http://v3.torontomls.net/Live/Pages/Public/Link.aspx?Key=14ed9b2ecf214e38886b2346b58a34b7&App=TREB"
	end

	def parse
		doc = Nokogiri::HTML(open(url)) do |config|
  			config.strict.nonet.noblanks
		end

		arr = []
		doc.css('tbody tr').each do |link| 
			arr << link
		end
		arr.each{ |item|
			extract_single_entry(item)
		}
	end

		def extract_single_entry(item)
			hash = Hash.from_xml(item.to_s)
			extra_details 	= JSON.parse(hash["tr"]["data_pop_up"])			
			data_ln 				= hash["tr"]["data_ln"].to_f
			data_lt 				= hash["tr"]["data_lt"].to_f
			data_identifier = hash["tr"]["data_identifier"]
			lp_dol 				= extra_details["lp_dol"].to_i
			type_own1_out	= extra_details["type_own1_out"] # home type [Detached]
			tot_area 			= extra_details["tot_area"]
			tot_areacd		= extra_details["tot_areacd"]
			lsc 					= extra_details["lsc"] # New \ sld
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
			entry.save!
		end


end