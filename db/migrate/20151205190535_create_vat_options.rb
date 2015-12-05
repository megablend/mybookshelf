class CreateVatOptions < ActiveRecord::Migration
  def change
    create_table :vat_options do |t|
      t.string :name, limit: 50, null: false
      t.integer :status, limit: 1, null: false
      t.timestamps null: false
    end
  end
end
