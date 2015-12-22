class CreateTemporaryEpubUpload < ActiveRecord::Migration
  def change
    create_table :temporary_epub_uploads do |t|
      t.string :file_name, null: false
      t.references :merchant, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
