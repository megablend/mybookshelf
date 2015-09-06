class AddAccountStatusToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :account_status, :integer, limit: 1, default: 1
  end
end
