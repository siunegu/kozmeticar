class Product < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :user
  belongs_to :category, counter_cache: true

  has_many :reservations


  scope :promoted, -> { where(:is_promoted => true) }
  scope :not_promoted, -> { where(:is_promoted => false) }
  scope :recent, -> { order("available_at ASC") }
  scope :upcoming, lambda { where("available_at between ? and ?", Date.today.beginning_of_day, Date.today.end_of_day) }
  # scope :identical, -> (available_at) { time_constraint "available_at = ?", available_at }


  validates :name, :presence => true
  validates :available_at, :presence => true
  validates :description, :presence => true
  validates :employee, :presence => true

  def self.search_and_order(search)
    if search
      where("name LIKE ?", "%#{search.downcase}%").order(
        is_promoted: :desc, name: asc).upcoming
    end
  end

end
