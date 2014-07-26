class Product < ActiveRecord::Base
  has_paper_trail

  belongs_to :user
  belongs_to :category, counter_cache: true

  has_many :reservations


  scope :promoted, -> { where(:is_promoted => true) }
  scope :not_promoted, -> { where(:is_promoted => false) }
  scope :recent, -> { order("available_at ASC") }
  scope :upcoming, lambda { where("available_at between ? and ?", Date.today.beginning_of_day, Date.today.end_of_day) }
  # First come first serve? Seems kinda stupid but whatever. Should add reservation slots to product so employees can set it themselfs
  # Theres a better solution to this but need to figure it out.
  # You shouldn't need to create the same product over and over again but rather just create it once and change the available at
  # whenever the product needs to be available again.
  scope :reservation_quota, lambda { where("reservations_count < reservation_slots") }


  validates :name, presence: true
  validates :available_at, presence: true
  validates :description, presence: true
  validates :employee, presence: true
  validates :price, presence: true


  def product_reservable
    # TODO
  end
end
