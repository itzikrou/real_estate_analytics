# == Schema Information
#
# Table name: realtor_entries
#
#  id         :integer          not null, primary key
#  data       :jsonb
#  mls_id     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RealtorEntry < ActiveRecord::Base
  # validations
  validates :mls_id, uniqueness: true

  def self.extract_realtor
    Property.all.each{|prop|
debugger      
      body = HttpAdapter.body(prop.longitude, prop.longitude+0.2, prop.latitude, prop.latitude+0.2)
      puts "PropID: #{prop.id}, coords: #{prop.longitude}, #{prop.latitude}"
      results = HttpAdapter.post(body)
      puts "Num of results: #{results['Results'].count}"
      puts "Num Of Entries: #{RealtorEntry.count}"
      results['Results'].each{|result|
        puts " This is the MLS number #{result['MlsNumber']}"
        RealtorEntry.create(mls_id: result['MlsNumber'], data: result)
      }
    }    
  end
end
