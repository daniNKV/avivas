class CreateProductsCollections < ActiveRecord::Migration[8.0]
  def change
    create_table :products_collections do |t|
      t.string :name
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
