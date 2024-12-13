class Invoice < ApplicationRecord
  has_one :user
  has_many :items
  has_many :products, through: :items


  def calculate_total
    items.sum { |item| item.quantity * item.price }
  end
end
