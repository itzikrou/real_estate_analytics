require 'open-uri'

class NewListingParser

	def parse_url(url)
		page = Nokogiri::HTML(open(url)) do |config|
  		config.strict.nonet.noblanks
		end
		parse(page)
	end

	def parse(html)
		general_summaries	= []
		detailed_reports	= []
		images_links			= []

		# get the summary
		html.css('tbody tr').each do |link| 
			general_summaries << link
		end
		
		# get entire entry data NEW
		html.css("div[class='reports view-pm'] div").each do |link| 
			detailed_reports << link 
		end

		# get entire entry data History
		if detailed_reports.blank?
			html.css("div[class='reports view-clf'] div").each do |link| 
				detailed_reports << link 
			end
		end

		print_date = extract_print_date(html)		

		# fetch all images links
		html.css("img").each do |link|
		 images_links << link
		end

		# build listing data
		build_entries(general_summaries, detailed_reports, images_links, print_date)
	end

	def bulk_import(file_path)
		line_num=0
		File.open(file_path).each do |line|
		  print "#{line_num += 1} #{line}"
		  parse(line)
		end
	end

private

	DATE_PATH 								= "//*[@id='form1']/div[3]/div[1]/div/div[3]"
	REPORTS_NEW_PATH					= "div[class='reports view-pm'] div"
	REPORTS_SOLD_PATH 				= "div[class='reports view-pm'] div"
	SUMMARY_PATH 							= "tbody tr"
	IMAGES_PATH								= "img"
	VALID_REPORTS_MIN_ENTRIES = 20

	def extract_print_date(page)
		header = page.css("div[class=header]").css("div")[5].text
		regex = /\d{1,2}\/\d{1,2}\/\d{4}/
		header[regex]
	end

	def build_entries(general_summaries, detailed_reports, images_links, print_date)
		valid_report_min_entries = 10
		detailed_attributes = []
		summary_attributes 	= []
		images 							= {}
		
		general_summaries.each{ |summary|
			summary_attributes.push(extract_summary_attributes(summary))
		}

		detailed_reports.each{ |detail_report|
			parsed_detailes = extract_detailed_attributes(detail_report)
			detailed_attributes.push(parsed_detailes)# unless parsed_detailes.blank?	|| parsed_detailes["MLS#:"].blank?
		}
		filtered_reports = detailed_attributes.uniq{|a| a["MLS#:"]}.compact #detailed_attributes.reject{|da| da.keys.count < valid_report_min_entries}.uniq
		images = extract_images_urls(images_links)
debugger		

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

	def extract_images_urls(images_data)
		images_links = {}		
		images_data.each{|image|
			urls = []			
			
			if image.as_json[0][1].blank?
				return
			end

			urls << image.as_json[0][1]
			mls_id = extract_mls_id_from_image_url(image.as_json[0][1])

			if image.has_attribute?('data-multi-photos')
				images = JSON.parse(image.as_json[3][1])
				images['multi-photos'].each{ |item|
					urls << item['url'] unless item['url'].blank?
				}
			end
			images_links[mls_id] = urls.uniq
		}		
		images_links
	end

	def extract_mls_id_from_image_url(url)		
			end_index 	= url.index('.jpg') - 1 rescue nil
			start_index = end_index - 7
			mls_id 			= url[start_index..end_index]
	end

	def extract_summary_attributes(summary_form)		
		hash = Hash.from_xml(summary_form.to_s)
		extra_details 	= JSON.parse(hash["tr"]["data_pop_up"])			
	end

	def create_listing(html)
		Listing.create!(raw_email: html.to_s)
	end

end
