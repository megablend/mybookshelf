class ProductsDescription < ActiveRecord::Base
   belongs_to :product, inverse_of: :products_description
end