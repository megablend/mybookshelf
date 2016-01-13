class ProductsType < ActiveRecord::Base
   has_many :products, inverse_of: :products_type
end