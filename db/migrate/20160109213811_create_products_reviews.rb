class CreateProductsReviews < ActiveRecord::Migration
  def change
    create_table :products_reviews do |t|
      t.references :product, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true
      t.string :author, limit: 64, null: false
      t.text :text, null: false
      t.integer :rating, limit: 1, null: false
      t.integer :status, limit: 1, null: false
      t.timestamps null: false
    end
  end
end
