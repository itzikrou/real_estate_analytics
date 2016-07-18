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

require 'test_helper'

class RealtorEntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
