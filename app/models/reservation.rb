class Reservation < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :user
  belongs_to :product

  validate :start_date_cannot_be_in_the_past

  def start_date_cannot_be_in_the_past
  	if starts_at && starts_at < DateTime.now + (15.minutes)
  		errors.add(:starts_at, 'has to be at least 15 minutes from present time')
  	end
  end

  def overlap?
  	#TODO
  end

  def self.new_reservations_count
    # Should return new reservation since last user updated at
  end

  def self.reservations_canceled
    #TODO
  end
end
