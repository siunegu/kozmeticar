class Product < ActiveRecord::Base
  has_paper_trail

  belongs_to :user
  belongs_to :category, counter_cache: true

  has_many :reservations


  scope :promoted, -> { where(:is_promoted => true) }
  scope :not_promoted, -> { where(:is_promoted => false) }
  scope :recent, -> { order("available_at ASC") }
  scope :upcoming, lambda { where("available_at between ? and ?", Date.today.beginning_of_day, Date.today.end_of_day) }


  validates :name, presence: true
  validates :available_at, presence: true
  validates :description, presence: true
  validates :employee, presence: true
end
