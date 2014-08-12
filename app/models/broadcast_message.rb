class BroadcastMessage < ActiveRecord::Base
  validates :message, presence: true
end