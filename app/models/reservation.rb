class Reservation < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :user
  belongs_to :product, counter_cache: true

  validate :start_date_cannot_be_in_the_past
  validate :slots_exceed

  # A user can only make a reservation on a product once
  validates :user_id, :uniqueness => { :scope => :product_id, message: "has already booked" }

  # This is cool. Lets Reservation use the available_at attribute from product.
  delegate :available_at, to: :product

  def start_date_cannot_be_in_the_past
    if starts_at && starts_at < DateTime.now + (15.minutes)
      errors.add(:starts_at, 'has to be at least 15 minutes from present time')
    end
  end

  def slots_exceed
    if product.reservations_count == product.reservation_slots
      errors.add(:base, "Already booked")
    end
  end

  def overlap?
  	# Check to see if any reservations overlap. Might not be needed if its first come first serve.
  end

  def self.new_reservations_today
    joins(:product).where("available_at between ? and ? and is_canceled = ?", 
      Date.today.beginning_of_day, Date.today.end_of_day, false).count
  end

  def self.reservations_canceled
      where("is_canceled = ?", true).count
  end
end
