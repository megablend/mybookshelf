class CreateProductsEbooks < ActiveRecord::Migration
  def change
    create_table :products_ebooks do |t|
      t.string :ebook, null: false
      t.references :product, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
