class CreateTemporaryProductsDescriptions < ActiveRecord::Migration
  def change
    create_table :temporary_products_descriptions do |t|
      t.references :products_type, index: true, foreign_key: true
      t.string :title, null: false
      t.string :isbn
      t.references :vat_option, index: true, foreign_key: true
      t.decimal :price, precision: 15, scale: 4, null: false, default: 0.0000
      t.decimal :special_price, precision: 15, scale: 4, default: 0.0000
      t.text :description, null: false
      t.integer :quantity, limit: 1, null: false, default: 0
      t.integer :product_protected, limit: 1, null: false, default: 0
      t.timestamps null: false
    end
  end
end
