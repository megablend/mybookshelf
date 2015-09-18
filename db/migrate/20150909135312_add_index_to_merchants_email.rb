class AddIndexToMerchantsEmail < ActiveRecord::Migration
  def change
  	add_index :merchants, :email, unique: true
  end
end
