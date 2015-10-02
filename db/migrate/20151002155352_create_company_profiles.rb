class CreateCompanyProfiles < ActiveRecord::Migration
  def change
    create_table :company_profiles do |t|
      t.string :name, limit: 100, null: false
      t.string :address, limit: 128, null: false
      t.string :email, limit: 96, null: false
      t.string :telephone, limit: 20, null: false
      t.string :facebook_profile, limit: 50
      t.string :twitter_profile, limit: 50
      t.string :google_plus_profile, limit: 50
      t.string :youtube_profile, limit: 50
      t.string :bbm_profile, limit: 50
    end
  end
end
