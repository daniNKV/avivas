class Invoice::Item < ApplicationRecord
  belongs_to :invoice
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def total_price
    product.price * quantity
  end
end
