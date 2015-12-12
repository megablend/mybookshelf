class RemoveProductProtectedFromTemporaryProductsDescriptions < ActiveRecord::Migration
  def change
  	remove_column :temporary_products_descriptions, :product_protected
  end
end
