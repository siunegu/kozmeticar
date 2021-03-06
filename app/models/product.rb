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


class Product < ActiveRecord::Base
  mount_uploader :cover, CoverUploader

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

  paginates_per 10


  def self.search_by_date(date)
    date = Date.parse(date)
    self.where("available_at > ? AND available_at < ?", date.beginning_of_day, date.end_of_day)
  end

  def time_available
    "#{available_at.strftime('%B %e, %H:%M')}"
  end
end
