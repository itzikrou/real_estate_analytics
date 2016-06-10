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
	end

		def self.noko1
			html = ScraperWiki::scrape("http://v3.torontomls.net/Live/Pages/Public/Link.aspx?Key=0c00bf31977a4a76a78484c9a6cbed52&App=TREB")
debugger			
			doc = Nokogiri::HTML(html)
			doc.css('table.data-list-row-number tr').each do |link| puts link.to_html end
			item = doc.css('table.data-list tr').each do |link| puts link['data-pop-up'] end
		end

end