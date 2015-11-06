class CategoriesController < ApplicationController
	
  # Load Merchants Helper
  include CategoriesHelper


  # get the subcategories of a category
  def get_sub_categories
      @active_category = params[:books_categories][:type]
  	 if  @active_category == "main-category"
	  	 category_id = params[:books_categories][:name][1].to_i
	  	 @sub_categories = Category.where(parent_id: category_id).order(:name)
	 else
        activate_selected_sub_category params[:books_categories][:sub_categories]
	 end
     respond_to do|format|
        format.html
        format.js
     end
  end

end