class Product < ActiveRecord::Base
   has_one :products_image, inverse_of: :product
   has_many :vat_options
end