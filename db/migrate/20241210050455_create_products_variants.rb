class CreateProductsVariants < ActiveRecord::Migration[8.0]
  def change
    create_table :products_variants do |t|
      t.string :name
      t.decimal :unit_price
      t.integer :stock_quantity
      t.string :color
      t.string :size
      t.string :material

      t.timestamps
    end
  end
end
