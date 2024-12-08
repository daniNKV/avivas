class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :phone
      t.string :first_name, limit: 50
      t.string :last_name, limit: 50
      t.integer :role, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.date :joined_at

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
