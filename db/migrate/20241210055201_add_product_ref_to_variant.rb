class AddProductRefToVariant < ActiveRecord::Migration[8.0]
  def change
    add_reference :product_variants, :product, null: false, foreign_key: true
  end
end
