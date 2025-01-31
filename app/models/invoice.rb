class Invoice < ApplicationRecord
  belongs_to :user
  has_many :items, class_name: "Invoice::Item"
  has_many :products, through: :items

  accepts_nested_attributes_for :items, allow_destroy: true

  validates :user, presence: true
  validates :items, presence: true 

  def canceled?
    status == :canceled
  end

  def calculate_total
    items.sum { |item| item.units * item.price }
  end
end
