class CreateProductsTypes < ActiveRecord::Migration
  def change
    create_table :products_types do |t|
      t.string :product_type, limit: 128, null: false
      t.timestamps null: false
    end
  end
end
