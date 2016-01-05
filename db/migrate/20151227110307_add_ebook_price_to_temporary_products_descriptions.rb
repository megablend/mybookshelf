class AddEbookPriceToTemporaryProductsDescriptions < ActiveRecord::Migration
  def change
    add_column :temporary_products_descriptions, :ebook_price, :decimal, precision: 15, scale: 4, default: 0.0000
  end
end
