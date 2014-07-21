class Category < ActiveRecord::Base
  has_paper_trail

  has_many :products, dependent: :nullify

  validates :name, presence: true
end
