class AddStatusToProductsTypes < ActiveRecord::Migration
  def change
    add_column :products_types, :status, :integer, limit: 1, default: 1
  end
end
