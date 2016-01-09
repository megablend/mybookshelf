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

  # list of to level categories
  def top_level_categories
     Category.where(parent_id: 0).order(:name).limit(8)
  end
  
  # list of sub-categories
  def sub_categories(parent_id)
    Category.where(parent_id: parent_id).order(:name)
  end

  # other categories
  def other_top_level_categories
    Category.where(parent_id: 0).order(:name).offset(9)
  end
end