class AddIndexToNameStoreTypes < ActiveRecord::Migration
  def change
  	 add_index :store_types, :name, unique: true
  end
end
