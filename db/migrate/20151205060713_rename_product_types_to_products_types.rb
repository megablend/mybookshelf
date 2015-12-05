class RenameProductTypesToProductsTypes < ActiveRecord::Migration
  def change
  	  rename_table :product_types, :products_types
  end
end
