class Product < ActiveRecord::Base
   belongs_to :products_type, inverse_of: :products
   belongs_to :vat_option, inverse_of: :products	
   has_one :products_image, inverse_of: :product
   has_one :products_description, inverse_of: :product
   has_one :products_ebook, inverse_of: :product
   has_one :products_category, inverse_of: :product
   has_one :category, through: :products_category
   has_many :products_reviews,  -> { where(status: true) }, inverse_of: :product

   # complex queries
   class << self

   end
end