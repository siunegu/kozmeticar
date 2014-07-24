class User < ActiveRecord::Base

  has_paper_trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :ensure_at_least_one_admin

  has_many :products
  has_many :reservations

  # By default this will make sure the first user to registers gets admin status
  def ensure_at_least_one_admin
    unless User.any?
      self.admin = true
    end
  end

end
