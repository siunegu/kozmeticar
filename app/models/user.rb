class User < ActiveRecord::Base

  has_paper_trail
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :ensure_at_least_one_admin

  has_many :products
  has_many :reservations

  # By default this will make sure the first user to registers gets admin status
  def ensure_at_least_one_admin
  	if User.count == 1
  		u = User.first
  		u.admin = true
  		u.save!
  	end
  end

end
