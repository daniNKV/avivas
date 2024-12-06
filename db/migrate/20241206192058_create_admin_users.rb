class CreateAdminUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.datetime :joined_at

      t.timestamps
    end
    add_index :admin_users, :username, unique: true
    add_index :admin_users, :email, unique: true
  end
end
