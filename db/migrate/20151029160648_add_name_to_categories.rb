class AddNameToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :name, :string, limit: 32, null: false
  end
end
