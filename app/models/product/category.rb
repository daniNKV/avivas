class Product::Category < ApplicationRecord
  has_one_attached :icon
  has_and_belongs_to_many :product

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 10000 }
end
