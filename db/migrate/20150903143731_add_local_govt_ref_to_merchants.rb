class AddLocalGovtRefToMerchants < ActiveRecord::Migration
  def change
    add_reference :merchants, :local_govt, index: true, foreign_key: true
  end
end
