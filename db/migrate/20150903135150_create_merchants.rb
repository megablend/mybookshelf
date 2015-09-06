class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :firstname, limit: 32, null: false
      t.string :lastname, limit: 32, null: false
      t.string :phone_number, limit: 32, null:false
      t.string :email, limit: 96, null: false
      t.string :address, limit: 128, null: false
      t.string :city, limit: 128, null: false
      t.string :landmark, limit: 128, null: false
      t.references :state, index: true, foreign_key: true
      t.string :password_digest, null: false
      t.string :remember_digest
      t.timestamps null: false
    end
  end
end
