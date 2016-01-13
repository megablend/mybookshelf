class ProductsImage < ActiveRecord::Base
   belongs_to :product, inverse_of: :products_image
end