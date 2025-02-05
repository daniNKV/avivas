class Invoice < ApplicationRecord
  belongs_to :user
  has_many :items, class_name: "Invoice::Item"
  has_many :products, through: :items

  accepts_nested_attributes_for :items, allow_destroy: true

  validates :user, presence: true
  validates :items, presence: true 
  validates :status, presence: true # Ensure status is always present

  enum :status, { active: 0, canceled: 1 }

  def cancel!
    return if canceled?

    ActiveRecord::Base.transaction do
      # Mark the invoice as canceled
      update!(status: :canceled)

      # Restore stock for each product in the invoice
      items.each do |item|
        product = item.product
        product.update!(stock_quantity: product.stock_quantity + item.units)
      end
    end
  end

  def calculate_total
    items.sum { |item| item.units * item.price }
  end
end
