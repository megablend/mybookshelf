class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :parent_id, limit: 11
      t.integer :position, limit: 11
      t.integer :level, limit: 11
      t.integer :children_count
      t.timestamps null: false
    end
  end
end
