class CategoriesController < ApplicationController
  # Load Merchants Helper
  include MerchantsHelper

  def get_sub_categories
     render plain: "Hello categories"
  end

end