class AddImageToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :image, :string, limit: 255
    add_column :categories, :description, :text
  end
end
