class AddEbookPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ebook_price, :decimal, precision: 15, scale: 4, default: 0.0000
  end
end
