class AddProductProtectedToTemporaryProductsDecriptions < ActiveRecord::Migration
  def change
  	add_column :temporary_products_descriptions, :product_protected, :integer, limit: 1, default: 1
  end
end
