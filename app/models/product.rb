class Product < ActiveRecord::Base
  has_paper_trail

  include PgSearch

  belongs_to :user
  belongs_to :category, counter_cache: true

  has_many :reservations

  pg_search_scope :search_by_name, :against => [:name, :price, :employee], :using => { :tsearch => { :prefix => true } }

  scope :promoted, -> { where(:is_promoted => true) }
  scope :not_promoted, -> { where(:is_promoted => false) }
  scope :recent, -> { order("available_at ASC") }
  scope :upcoming, lambda { where("available_at between ? and ?", Date.today.beginning_of_day, Date.today.end_of_day) }
  scope :reservation_quota, lambda { where("reservations_count < reservation_slots") }


  validates :name, presence: true
  validates :available_at, presence: true
  validates :description, presence: true
  validates :employee, presence: true
  validates :price, presence: true

  def self.search_by_date(date)
    date = Date.parse(date)
    self.where("available_at > ? AND available_at < ?", date.beginning_of_day, date.end_of_day)
  end
end
