module Admin::ProductsHelper
  def humanize_boolean(value)
    value ? "Yes" : "No"
  end

  def humanize_published(value)
    value ? "Published" : "Hidden"
  end
end
