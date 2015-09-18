class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name, limit: 128, null: false
      t.text :description
      t.string :url, limit: 128, null: false
      t.references :store_type, index: true, foreign_key: true
      t.references :merchant, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
