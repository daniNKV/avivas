module Admin::ProductsHelper
  def humanize_boolean(value)
    value ? "Yes" : "No"
  end

  def humanize_published(value)
    value ? "Published" : "Hidden"
  end

  def product_image_url(product)
    if product.images.attached?
      Rails.application.routes.url_helpers.rails_blob_path(product.images.first, only_path: true)
    else
      "/images/default_product.webp"
    end
  end
end
