class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :firstname, limit: 32, null: false
      t.string :lastname, limit: 32, null: false
      t.string :email, limit: 96, null: false
      t.string :telephone, limit: 32, null: false
      t.string :password_digest, null: false
      t.text :cart
      t.text :wishlist
      t.integer :newsletter, limit: 1, default: 0
      t.integer :status, limit: 1, default: 1
      t.integer :approved, limit: 1, default: 0
      t.string :token
      t.timestamps null: false
    end
  end
end
