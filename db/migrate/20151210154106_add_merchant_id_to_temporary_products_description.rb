class AddMerchantIdToTemporaryProductsDescription < ActiveRecord::Migration
  def change
    add_reference :temporary_products_descriptions, :merchant, index: true, foreign_key: true
  end
end
