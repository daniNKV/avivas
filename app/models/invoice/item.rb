class Invoice::Item < ApplicationRecord
  belongs_to :invoice
  belongs_to :product

  validates :product, presence: true
  validates :units, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def total_price
    product.price * quantity
  end
end
