class Product < ApplicationRecord
  has_many_attached :images
  has_and_belongs_to_many :collections
  has_and_belongs_to_many :categories,
                          join_table: "product_categories_products",
                          foreign_key: :product_id,
                          association_foreign_key: :product_category_id
  has_many :items
  has_many :invoices, through: :items

  validates :name, presence: true, length: { maximum: 255 }
  validates :color, length: { maximum: 50 }
  validates :sizes_available, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 10000 }
  validates :base_price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }

  scope :by_name_or_description, ->(query) { where("lower(name) LIKE :search OR lower(description) LIKE :search",
                                             search: "%#{query.downcase}%")
  }
  scope :deleted_ones, ->(flag) { where(deleted: flag) }
  scope :deleted_count, -> { where(deleted_at: nil).count }
  scope :published_count, -> { where(published: true).count }
  scope :published_products, -> { where(published: true) }
  scope :by_category, ->(category) { where(category: category) }

  def published?
    self.published
  end

  def total_units_sold
    items.sum(:units)
  end

  def delete
    self.deleted = true
    self.deleted_at = Time.zone.now
    self.published = false
    self.stock_quantity = 0
    self.save
  end

  def product_image_url
    if images.attached?
      Rails.application.routes.url_helpers.rails_blob_path(images.first, only_path: true)
    else
      "/images/default_product.webp"
    end
  end
end
