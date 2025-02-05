class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :total_price
      t.decimal :discount
      t.datetime :transaction_date, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :status, default: 0, null: false
      t.text :notes

      t.timestamps
    end
  end
end
