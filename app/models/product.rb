class Product < ApplicationRecord
  has_many_attached :images
  has_many :variants, dependent: :destroy
  has_and_belongs_to_many :collections
  has_and_belongs_to_many :categories


  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 10000 }
  validates :base_price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }

  scope :by_name_or_description, ->(query) { where("lower(name) LIKE :search OR lower(description) LIKE :search",
                                             search: "%#{query.downcase}%")
  }

  def published?
    self.published == true
  end

  def product_image_url
    if images.attached?
      Rails.application.routes.url_helpers.rails_blob_path(images.first, only_path: true)
    else
      "/images/default_product.webp"
    end
  end
end
