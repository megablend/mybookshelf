class AddSpecialPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :special_price, :decimal, precision: 15, scale: 4, default: 0.0000
  end
end
