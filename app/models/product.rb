class Product < ActiveRecord::Base	
   has_one :products_image, inverse_of: :product
   has_one :products_description, inverse_of: :product
   has_one :products_ebook, inverse_of: :product
   has_one :products_category
   # has_one :category, through: :products_category
end