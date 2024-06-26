class Product < ApplicationRecord
  validates :code, :name, :category, presence: true
  validates :code, uniqueness: true

  has_many :orders
end