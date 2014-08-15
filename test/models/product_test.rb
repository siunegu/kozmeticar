# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  available_at       :datetime
#  is_promoted        :boolean          default(FALSE)
#  user_id            :integer
#  description        :text
#  created_at         :datetime
#  updated_at         :datetime
#  employee           :string(255)
#  price              :string(255)
#  category_id        :integer
#  reservations_count :integer          default(0)
#  reservation_slots  :integer          default(1)
#  cover              :string(255)
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
