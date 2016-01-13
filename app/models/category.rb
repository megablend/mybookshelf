class Category < ActiveRecord::Base
  has_many :products_categories, inverse_of: :category
  has_many :products, through: :products_categories
end