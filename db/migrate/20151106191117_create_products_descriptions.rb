class CreateProductsDescriptions < ActiveRecord::Migration
  def change
    create_table :products_descriptions do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.text :description
      t.references :product, index: true, foreign_key: true
      t.string :publisher
      t.date :publish_date
      t.text :tag
      t.string :meta_title, null: false
      t.string :meta_description, null: false
      t.string :meta_keyword, null: false
    end
  end
end
