# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  html       :text
#  url        :string
#  exported   :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base

  validates :url, uniqueness: true
  before_create :scrape_html_data

  def to_xml
    info_doc = Nokogiri::XML(self.raw_email)
  end

  def to_html
    info_doc = Nokogiri::HTML(self.raw_email)
  end

  def write_to_file(full_path)
    File.open(full_path, 'w') { |file| file.write(self.raw_email) }
  end

  def extract_data
    NewListingParser.new.parse(to_html)
  end

  def scrape_html_data    
    html = NewListingParser.new.scrape_url(self.url)   
  end
end
