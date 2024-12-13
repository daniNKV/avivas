class Invoice < ApplicationRecord
  belongs_to :user
  has_many :items, class_name: "Invoice::Item"
  has_many :products, through: :items
  accepts_nested_attributes_for :items, allow_destroy: false

  enum :status, [ :active, :canceled ], suffix: true

  def canceled?
    status == :canceled
  end

  def calculate_total
    items.sum { |item| item.quantity * item.price }
  end
end
