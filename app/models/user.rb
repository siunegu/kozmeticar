# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  admin                  :boolean
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  firstname              :string(255)
#  lastname               :string(255)
#

class User < ActiveRecord::Base

  has_paper_trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :ensure_at_least_one_admin

  has_many :products
  has_many :reservations
  has_many :visits

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
    return false unless self.update_at > 5.minutes.ago
  end

end
