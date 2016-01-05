class AddEbookProtectedToProductsEbooks < ActiveRecord::Migration
  def change
    add_column :products_ebooks, :ebook_protected, :integer, limit: 1, default: 0
  end
end
