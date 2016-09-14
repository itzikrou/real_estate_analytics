# == Schema Information
#
# Table name: entries
#
#  id             :integer          not null, primary key
#  mls_id         :string
#  address        :string
#  street_name    :string
#  street_number  :string
#  listing_status :string
#  municipality   :string
#  apt_unit       :string
#  beds           :integer
#  wr             :integer
#  lsc            :string
#  list_price     :integer
#  sale_price     :integer
#  postal         :string
#  listing_type   :string
#  dom            :integer
#  taxes          :integer
#  client_remarks :text
#  raw_data       :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Entry < ActiveRecord::Base

	def get_max_return_streets
		arr = []
		postals = Entry.all.pluck(:postal)
		postals.each{|postal|			
			avg_lease = Entry.where(postal: postal).where(lsc: 'Lsd').average(:list_price)
			avg_sale = Entry.where(postal: postal).where(lsc: 'Sld').average(:list_price)			
			if avg_lease.present? && avg_sale.present?				
				arr.push({ percent: (((avg_lease*12)-2800) / avg_sale ) * 100, postal: postal })
			end
		}
		arr
	end

end
