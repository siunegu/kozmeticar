# == Schema Information
#
# Table name: broadcast_messages
#
#  id         :integer          not null, primary key
#  message    :text
#  alert_type :integer
#  created_at :datetime
#  updated_at :datetime
#

class BroadcastMessage < ActiveRecord::Base
  validates :message, presence: true
end
