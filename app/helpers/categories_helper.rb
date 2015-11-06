module CategoriesHelper

  # return the selected sub-category
  def activate_selected_sub_category(category_id)
     session[:selected_sub_category] = category_id
  end
  
  # check if the merchant selected a category
  def selected_sub_catgeory?
     !session[:selected_sub_catgeory].nil?
  end

  def deactivate_selected_sub_category
     session.delete(:selected_sub_catgeory)
  end
end