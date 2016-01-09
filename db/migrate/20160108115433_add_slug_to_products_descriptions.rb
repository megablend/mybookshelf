class AddSlugToProductsDescriptions < ActiveRecord::Migration
  def change
    add_column :products_descriptions, :slug, :string, null: false
  end
end
