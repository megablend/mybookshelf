class CreateCategoriesImages < ActiveRecord::Migration
  def change
    create_table :categories_images do |t|
      t.references :category, index: true, foreign_key: true
      t.string :page_image, null: false
      t.string :menu_image, null: false
      t.timestamps null: false
    end
  end
end
