class Product < ActiveRecord::Base
   has_one :products_image, inverse_of: :product
end