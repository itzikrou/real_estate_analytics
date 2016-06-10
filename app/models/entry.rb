# == Schema Information
#
# Table name: entries
#
#  id             :integer          not null, primary key
#  mls_id         :string
#  address        :string
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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Entry < ActiveRecord::Base
end
