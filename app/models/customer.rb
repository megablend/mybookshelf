class Customer < ActiveRecord::Base
   has_many :products_reviews, inverse_of: :customer
end