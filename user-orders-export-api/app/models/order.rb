class Order < ApplicationRecord
  validates :order_date, presence: true

  belongs_to :user
  belongs_to :product
end
