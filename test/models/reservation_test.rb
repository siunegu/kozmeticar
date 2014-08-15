# == Schema Information
#
# Table name: reservations
#
#  id          :integer          not null, primary key
#  starts_at   :datetime
#  user_id     :integer
#  product_id  :integer
#  is_canceled :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
