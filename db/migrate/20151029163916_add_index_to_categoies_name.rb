class AddIndexToCategoiesName < ActiveRecord::Migration
  def change
    add_index :categories, [:name, :parent_id], unique: true
  end
end
