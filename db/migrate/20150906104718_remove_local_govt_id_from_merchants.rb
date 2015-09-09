class RemoveLocalGovtIdFromMerchants < ActiveRecord::Migration
  def change
    remove_reference :merchants, :local_govt, index: true, foreign_key: true
  end
end
