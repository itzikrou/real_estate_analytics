require 'open-uri'

class NewListingParser

	def parse(url)

		general_summaries 	= []
		detailed_reports 		= []
		page = Nokogiri::HTML(open(url)) do |config|
  			config.strict.nonet.noblanks
		end

		# add raw html to database
		# self.create_listing(page)

		page.css('tbody tr').each do |link| 
			general_summaries << link
		end
		
		# get entire entry data NEW
		page.css("div[class='reports view-pm'] div").each do |link| 
			detailed_reports << link 
		end

		# get entire entry data History
		if detailed_reports.blank?
			page.css("div[class='reports view-clf'] div").each do |link| 
				detailed_reports << link 
			end
		end
		# build listing data
		build_entries(general_summaries, detailed_reports)

	end

	def build_entries(general_summaries, detailed_reports)
		valid_report_min_entries = 20
		detailed_attributes = []
		summary_attributes 	= []
		general_summaries.each{ |summary|
			summary_attributes.push(extract_summary_attributes(summary))
		}

		detailed_reports.each{ |detail_report|
			parsed_detailes = extract_detailed_attributes(detail_report)
			detailed_attributes.push(parsed_detailes) unless parsed_detailes.blank?	|| parsed_detailes["MLS#:"].blank?
		}
		filtered_reports = detailed_attributes.reject{|da| da.keys.count < valid_report_min_entries}.uniq
	end

	def extract_detailed_attributes(property_form)
		form_items = []
		entry_detailed_attributes = {}

		property_form.css("span[class = 'formitem formfield']").each do |form_item| 
			form_items << form_item 
		end

		form_items.each{|item|
			if item.css('label').text.present? && item.css('span').text.present?
				entry_detailed_attributes[item.css('label').text] = item.css('span').text
			end	
		}
		entry_detailed_attributes
	end

	def extract_summary_attributes(summary_form)
		hash = Hash.from_xml(summary_form.to_s)
		extra_details 	= JSON.parse(hash["tr"]["data_pop_up"])			
		# data_ln 				= hash["tr"]["data_ln"].to_f
		# data_lt 				= hash["tr"]["data_lt"].to_f
		# data_identifier = hash["tr"]["data_identifier"]
		# lp_dol 				= extra_details["lp_dol"].to_i
		# type_own1_out	= extra_details["type_own1_out"] # home type [Detached]
		# tot_area 			= extra_details["tot_area"]
		# tot_areacd		= extra_details["tot_areacd"]
		# lsc 					= extra_details["lsc"] # New \ Sld \ Lsd
		# addr 					= extra_details["addr"]
		# apt_num 			= extra_details["apt_num"]
		# ml_num				= extra_details["ml_num"]
		# latitude			= extra_details["latitude"].to_f
		# longitude			= extra_details["longitude"].to_f
		# municipality 	= extra_details["municipality"]
		# zip						= extra_details["zip"]
		# br						= extra_details["br"].to_i
		# bath_tot			= extra_details["bath_tot"]
		# style					= extra_details["style"] #1 1/2 Storey \ Bungalow-Raised \ 2-Storey \ Apartment
		# raw_data 			= item.to_s

		# client_remarks = item.xpath("//*[@id=\"#{ml_num}\"]/div[2]/div[2]/div[1]/div/div[7]/span[1]/span/text()")			
		# extras = item.xpath("//*[@id=\"#{ml_num}\"]/div[2]/div[2]/div[1]/div/div[7]/span[2]/span/text()")
		# dom = item.xpath("//*[@id=\"#{ml_num}\"]/div[2]/div[2]/div[1]/div/div[1]/div/div[2]/div[4]/div[3]/span/span/text()").to_s
		
		# # Taxes
		# taxes 	= item.xpath("//*[@id=\"#{ml_num}\"]/div[2]/div[2]/div[1]/div/div[1]/div/div[2]/div[2]/div[1]/div/span[1]/span/text()").to_s
		# taxes.slice!('$')
		# taxes.slice!(',')

		# # lot
		# lot = item.xpath("//*[@id=\"#{ml_num}\"]/div[2]/div[2]/div[1]/div/div[1]/div/div[2]/div[4]/div[1]/div[1]/span[3]/span/text()")

		# # Street & Number
		# white_space_index = addr.index(' ')
		# street_name = addr[white_space_index..addr.size].strip
		# street_number = addr[0..white_space_index-1].strip

	end

	def bulk_import(file_path)
		line_num=0
		File.open(file_path).each do |line|
		  print "#{line_num += 1} #{line}"
		  parse(line)
		end
	end

private

	def create_listing(html)
		Listing.create!(raw_email: html.to_s)
	end


end