require 'open-uri'

class Parser

	def self.parse
		Wombat.crawl do
		  base_url "http://v3.torontomls.net"
		  path "/Live/Pages/Public/Link.aspx?Key=0c00bf31977a4a76a78484c9a6cbed52&App=TREB"

		  links do
		    explore xpath: '//*[@class="data-list"]' do |e|
debugger
		      e.gsub(/  /, " ") 
		    end
		  end
		end
	end


	def self.noko
		# doc = Nokogiri::XML(File.open("http://v3.torontomls.net/Live/Pages/Public/Link.aspx?Key=8f41647c2786457da2c575a64a4bb785&App=TREB")) do |config|
		#   config.strict.nonet
		doc = Nokogiri::HTML(open("http://v3.torontomls.net/Live/Pages/Public/Link.aspx?Key=0c00bf31977a4a76a78484c9a6cbed52&App=TREB")) do |config|
  			config.strict.nonet.noblanks
		end
debugger		
		doc.css('table.data-list-row-number tr').each do |link| puts link.to_html end
	end

		# def self.noko1
		# doc = Nokogiri::HTML(open("http://v3.torontomls.net/Live/Pages/Public/Link.aspx?Key=0c00bf31977a4a76a78484c9a6cbed52&App=TREB")) do |config|
  # 			config.strict.nonet.noblanks
		# end
		# 	doc = Nokogiri::HTML(html)
		# 	doc.css('table.data-list-row-number tr').each do |link| puts link.to_html end
		# 	item = doc.css('table.data-list tr').each do |link| puts link['data-pop-up'] end
		# end

end


# doc.css('tr.even tr').each do |link| puts link.to_html end
# <td class="data-list-row-number">2</td>
# <td class="align-center">62 Stollar Blvd</td>
# <td class="align-center">&nbsp;</td>
# <td class="align-center">Barrie</td>
# <td class="align-left">$489,000.00</td>
# <td class="align-left">3</td>
# <td class="align-left">3</td>
# <td class="align-center">New</td>
# <td class="align-left">X3514785</td>



# item = doc.css('table.data-list tr').each do |link| puts link['data-pop-up'] end
# {"Photo":"","lp_dol":"428000.00","lp_code":"","ml_num":"X3495657","type_own1_out":"Detached","tot_area":"","tot_areacd":"","lsc":"New","addr":"10 Glenecho  Dr","apt_num":"","municipality":"Barrie","zip":"L4M4J3","PropertyDetail":"","ListNum":"","latitude":"44.40763","longitude":"-79.66434","class":"Free","br":"3","bath_tot":"4","province":"","style":"Bungalow-Raised"}
# {"Photo":"","lp_dol":"489000.00","lp_code":"","ml_num":"X3514785","type_own1_out":"Detached","tot_area":"","tot_areacd":"","lsc":"New","addr":"62 Stollar Blvd","apt_num":"","municipality":"Barrie","zip":"L4M6N3","PropertyDetail":"","ListNum":"","latitude":"44.41715","longitude":"-79.69273","class":"Free","br":"3","bath_tot":"3","province":"","style":"2-Storey"}


# item = doc.css('tbody tr').each do |link| puts link end
# <tr class="even" data-map-class="status-New" data-ln="-79.66434" data-lt="44.40763" data-identifier="X3495657" data-pop-up='{"Photo":"","lp_dol":"428000.00","lp_code":"","ml_num":"X3495657","type_own1_out":"Detached","tot_area":"","tot_areacd":"","lsc":"New","addr":"10 Glenecho  Dr","apt_num":"","municipality":"Barrie","zip":"L4M4J3","PropertyDetail":"","ListNum":"","latitude":"44.40763","longitude":"-79.66434","class":"Free","br":"3","bath_tot":"4","province":"","style":"Bungalow-Raised"}'>
# <td class="data-list-row-number">1</td>
# <td class="align-center">10 Glenecho  Dr</td>
# <td class="align-center">&nbsp;</td>
# <td class="align-center">Barrie</td>
# <td class="align-left">$428,000.00</td>
# <td class="align-left">3</td>
# <td class="align-left">4</td>
# <td class="align-center">New</td>
# <td class="align-left">X3495657</td>
# </tr>
# <tr class="odd" data-map-class="status-New" data-ln="-79.69273" data-lt="44.41715" data-identifier="X3514785" data-pop-up='{"Photo":"","lp_dol":"489000.00","lp_code":"","ml_num":"X3514785","type_own1_out":"Detached","tot_area":"","tot_areacd":"","lsc":"New","addr":"62 Stollar Blvd","apt_num":"","municipality":"Barrie","zip":"L4M6N3","PropertyDetail":"","ListNum":"","latitude":"44.41715","longitude":"-79.69273","class":"Free","br":"3","bath_tot":"3","province":"","style":"2-Storey"}'>
# <td class="data-list-row-number">2</td>
# <td class="align-center">62 Stollar Blvd</td>
# <td class="align-center">&nbsp;</td>
# <td class="align-center">Barrie</td>
# <td class="align-left">$489,000.00</td>
# <td class="align-left">3</td>
# <td class="align-left">3</td>
# <td class="align-center">New</td>
# <td class="align-left">X3514785</td>
# </tr>