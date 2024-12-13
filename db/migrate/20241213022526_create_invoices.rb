class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.decimal :total_price
      t.decimal :discount
      t.datetime :transaction_date
      t.text :notes

      t.timestamps
    end
  end
end
