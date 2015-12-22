class AddColumnsToTemporaryProductsDescriptions < ActiveRecord::Migration
  def change
    add_column :temporary_products_descriptions, :author, :string, limit: 128
    add_column :temporary_products_descriptions, :publisher, :string, limit: 128
    add_column :temporary_products_descriptions, :publish_date, :date
  end
end
