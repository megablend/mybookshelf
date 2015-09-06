class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name, :limit => 64, null: false
      t.timestamps null: false
    end
  end
end
