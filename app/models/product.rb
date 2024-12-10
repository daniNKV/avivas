class Product < ApplicationRecord
  has_many_attached :images
  has_many :variants, dependent: :destroy
  has_and_belongs_to_many :collections
  has_and_belongs_to_many :categories


  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 10000 }
  validates :base_price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }

end
