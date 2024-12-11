class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :base_price, default: 0.0
      t.integer :stock_quantity, default: 0
      t.boolean :published, default: true
      t.boolean :deleted, default: false
      t.datetime :deleted_at, default: nil

      t.timestamps
    end
  end
end
