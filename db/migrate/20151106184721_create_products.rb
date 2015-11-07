class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :isbn_number, limit: 64
      t.string :resource_id, limit: 10
      t.integer :quantity, limit: 4, default: 0
      t.references :merchant, index: true, foreign_key: true
      t.references :product_type, index: true, foreign_key: true
      t.decimal :price, precision: 15, scale: 4, default: 0.0000
      t.integer :points, limit: 8, default: 0
      t.integer :status, limit: 1, default: 0
      t.integer :approved, limit: 1, default: 0
      t.integer :viewed, limit: 5, default: 0
      t.timestamp null: false
    end
  end
end
