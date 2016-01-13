class VatOption < ActiveRecord::Base
   has_many :products, inverse_of: :vat_option
end