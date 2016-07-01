# == Schema Information
#
# Table name: properties
#
#  id              :integer          not null, primary key
#  mls_id          :string
#  for             :string
#  address         :string
#  street_name     :string
#  street_number   :string
#  longtitude      :float
#  latitude        :float
#  listing_status  :string
#  municipality    :string
#  home_type       :string
#  home_style      :string
#  apt_unit        :string
#  bedrooms        :integer
#  washrooms       :integer
#  kitchens        :integer
#  sqft_from       :integer
#  sqft_to         :integer
#  basement        :string
#  fronting_on     :string
#  family_rooms    :integer
#  heat_type       :string
#  air_conditioner :string
#  exterior        :string
#  drive           :string
#  garage          :string
#  parking_spaces  :integer
#  water           :string
#  sewer           :string
#  lot_length      :float
#  lot_width       :float
#  rooms           :integer
#  pool            :string
#  cross_streets   :string
#  last_status     :string
#  list_price      :integer
#  leased_price    :integer
#  sale_price      :integer
#  postal          :string
#  listing_type    :string
#  dom             :integer
#  taxes           :integer
#  client_remarks  :text
#  images_links    :jsonb
#  print_date      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Property < ActiveRecord::Base
end
