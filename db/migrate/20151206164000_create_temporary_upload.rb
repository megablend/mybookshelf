class CreateTemporaryUpload < ActiveRecord::Migration
  def change
    create_table :temporary_uploads do |t|
      t.string :upload_type, limit: 32, null: false
      t.string :file_name, null: false
      t.references :merchant, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
