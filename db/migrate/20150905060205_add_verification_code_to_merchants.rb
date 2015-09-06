class AddVerificationCodeToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :verification_code, :string, limit: 12
  end
end
