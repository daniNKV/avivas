class Product::Collection < ApplicationRecord
  has_many_attached :images
  has_and_belongs_to_many :product

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 10000 }
end
