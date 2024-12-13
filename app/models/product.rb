class Product < ApplicationRecord
  has_many_attached :images
  has_and_belongs_to_many :collections
  has_and_belongs_to_many :categories,
                          join_table: "product_categories_products",
                          foreign_key: :product_id,
                          association_foreign_key: :product_category_id

  validates :name, presence: true, length: { maximum: 255 }
  validates :color, length: { maximum: 50 }
  validates :sizes_available, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 10000 }
  validates :base_price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }

  scope :by_name_or_description, ->(query) { where("lower(name) LIKE :search OR lower(description) LIKE :search",
                                             search: "%#{query.downcase}%")
  }

  def published?
    self.published
  end

  def product_image_url
    if images.attached?
      Rails.application.routes.url_helpers.rails_blob_path(images.first, only_path: true)
    else
      "/images/default_product.webp"
    end
  end
end
