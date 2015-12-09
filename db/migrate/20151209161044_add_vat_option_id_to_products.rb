class AddVatOptionIdToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :vat_option, index: true, foreign_key: true
  end
end
