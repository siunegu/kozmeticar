class Reservation < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :user
  belongs_to :product, counter_cache: true

  validate :start_date_cannot_be_in_the_past

  # A user can only make a reservation on a product once
  validates :user_id, :uniqueness => { :scope => :product_id }

  def start_date_cannot_be_in_the_past
    if starts_at && starts_at < DateTime.now + (15.minutes)
      errors.add(:starts_at, 'has to be at least 15 minutes from present time')
    end
  end

  def overlap?
  	#TODO
  end

  def self.new_reservations_today
    joins(:product).where("available_at between ? and ? and is_canceled = ?", 
      Date.today.beginning_of_day, Date.today.end_of_day, false).count
  end

  def self.reservations_canceled
      where("is_canceled = ?", true).count
  end
end
