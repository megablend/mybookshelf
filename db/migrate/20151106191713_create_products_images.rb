class CreateProductsImages < ActiveRecord::Migration
  def change
    create_table :products_images do |t|
      t.references :product, index: true, foreign_key: true
      t.string :image
      t.timestamps null: false
    end
  end
end
