class AddIndexToStoresUrl < ActiveRecord::Migration
  def change
    add_index :stores, :url, unique: true
  end
end
