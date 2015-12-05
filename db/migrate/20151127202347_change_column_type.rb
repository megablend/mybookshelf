class ChangeColumnType < ActiveRecord::Migration
  def change
  	rename_column :product_types, :type, :product_type
  end
end
