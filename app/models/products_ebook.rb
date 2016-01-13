class ProductsEbook < ActiveRecord::Base
   belongs_to :product, inverse_of: :products_ebook
end