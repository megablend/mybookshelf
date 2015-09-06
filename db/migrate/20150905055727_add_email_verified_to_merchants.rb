class AddEmailVerifiedToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :email_verified, :integer, limit: 1, default: 0
  end
end
