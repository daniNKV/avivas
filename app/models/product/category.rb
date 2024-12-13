class Product::Category < ApplicationRecord
  has_one_attached :icon
  has_and_belongs_to_many :products,
                          join_table: "product_categories_products",
                          foreign_key: :product_category_id,
                          association_foreign_key: :product_id

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 10000 }
end
