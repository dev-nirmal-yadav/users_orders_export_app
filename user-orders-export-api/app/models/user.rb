class User < ApplicationRecord
  validates :username, :email, :phone, presence: true
  validates :email, uniqueness: true

  has_many :orders
end