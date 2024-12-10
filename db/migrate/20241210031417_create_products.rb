class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :unit_price
      t.integer :stock
      t.boolean :published
      t.boolean :deleted
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
