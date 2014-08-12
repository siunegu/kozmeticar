class User < ActiveRecord::Base

  has_paper_trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :ensure_at_least_one_admin

  has_many :products
  has_many :reservations

  validates :firstname, presence: true
  validates :lastname, presence: true

  # By default this will make sure the first user to registers gets admin status
  def ensure_at_least_one_admin
    unless User.any?
      self.admin = true
    end
  end

  def self.last_signups(count)
    order(created_at: :desc).limit(count).select("id", "email", "created_at")
  end

  def fullname
    "#{firstname} #{lastname}"
  end

  def online?
    return false unless self.update_at
    self.update_at > 5.minutes.ago
  end

end
