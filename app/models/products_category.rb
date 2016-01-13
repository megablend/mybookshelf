class ProductsCategory < ActiveRecord::Base
   belongs_to :product, inverse_of: :products_category
   belongs_to :category, inverse_of: :products_categories
end