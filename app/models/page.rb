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

  # validations
  validates :url, uniqueness: true

  # callbacks
  before_create :scrape_html_data
  after_save :extract_data

  # def to_xml
  #   info_doc = Nokogiri::XML(self.html)
  # end

  def to_html
    info_doc = Nokogiri::HTML(self.html)
  end

  def write_to_file(full_path)
    File.open(full_path, 'w') { |file| file.write(self.html) }
  end

  def extract_data
    entries = NewListingParser.new.parse(to_html)
    entries.each{|entry|
      ListingDataAdapterService.new(entry).create_listing
    }    
  end

  def scrape_html_data_from_url
    self.html = NewListingParser.new.scrape_url(self.url)
  end

  def export_all_to_files(path)
    Page.all.each{|p| p.write_to_file("#{path}\\#{i+1}.txt") ; i = i+1}
  end

end
