class CreateProductsCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :products_categories do |t|
      t.string :name
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
