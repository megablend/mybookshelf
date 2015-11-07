class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :type, limit: 128, null: false
      t.timestamps null: false
    end
  end
end
