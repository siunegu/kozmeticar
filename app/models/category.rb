# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :text
#  products_count :integer          default(0)
#  created_at     :datetime
#  updated_at     :datetime
#

class Category < ActiveRecord::Base
  has_paper_trail

  has_many :products, dependent: :nullify

  validates :name, presence: true
end
