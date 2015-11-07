class CreateProductsCategories < ActiveRecord::Migration
  def change
    create_table :products_categories, :id => false do |t|
      t.references :product, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
    end
  end
end
