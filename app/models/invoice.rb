class Invoice < ApplicationRecord
  belongs_to :user
  has_many :items
  has_many :products, through: :items
  accepts_nested_attributes_for :items

  enum :status, [ :active, :canceled ], suffix: true


  def calculate_total
    items.sum { |item| item.quantity * item.price }
  end
end
