class CartController < ApplicationController
  # carts helper
  include CartHelper

  # list of items in cart 
  def index
     
  end

  # add print books to cart
  def add_book
     data_response = Hash.new
     product = Product.find(cart_add_product_params[:product_id].to_i)

    # add product to cart
 	add_cart cart_add_product_params[:product_id], cart_add_product_params[:quantity].to_i
 	data_response[:success] = ApplicationLanguages.shopping_cart_language "text_success", product.products_description.title
 	data_response[:total] = cart_title

 	 # respond to request
     respond_to do|format|
        format.json { render :json => { message: data_response.to_json } }
  	 end
  end

  # add products to cart
  def add_product
     data_response = Hash.new
     product = Product.find(cart_add_product_params[:product_id].to_i)

     if cart_add_product_params[:selected_option] == "Print Book"
     	# add product to cart
     	add_cart cart_add_product_params[:product_id], cart_add_product_params[:quantity].to_i
     	data_response[:success] = ApplicationLanguages.shopping_cart_language "text_success", product.products_description.title
     	data_response[:total] = cart_title
     else
        # check if ebook has been added before
        if ebook_in_cart?(cart_add_product_params[:product_id])
           data_response[:error] = ApplicationLanguages.shopping_cart_language "text_ebook_error", product.products_description.title
        else
           add_ebook_cart cart_add_product_params[:product_id]
           data_response[:success] = ApplicationLanguages.shopping_cart_language "text_success", product.products_description.title
           data_response[:total] = cart_title
        end
     end

     # respond to request
     respond_to do|format|
        format.json { render :json => { message: data_response.to_json } }
  	 end
  end

  # load cart details
  def load_cart
     render partial: "layouts/frontend/cart"
  end
  
  # add ebook products to cart
  def add_ebook
  	data_response = Hash.new
    product = Product.find(cart_add_product_params[:product_id].to_i)

  	# check if ebook has been added before
    if ebook_in_cart?(cart_add_product_params[:product_id])
       data_response[:error] = ApplicationLanguages.shopping_cart_language "text_ebook_error", product.products_description.title
    else
       add_ebook_cart cart_add_product_params[:product_id]
       data_response[:success] = ApplicationLanguages.shopping_cart_language "text_success", product.products_description.title
       data_response[:total] = cart_title
    end

     # respond to request
     respond_to do|format|
        format.json { render :json => { message: data_response.to_json } }
  	 end
  end

  # delete a single cart item
  def delete_item
     data_response = Hash.new

     if process_delete_cart_item(cart_add_product_params[:product_type], cart_add_product_params[:product_id])
     	data_response[:status] = true
     	data_response[:total] = cart_title
     else
     	data_response[:status] = false
     end

     # respond to request
     respond_to do|format|
        format.json { render :json => { message: data_response.to_json } }
  	 end
  end

  private 
    def cart_add_product_params
      params.require(:cart_data).permit(:product_id, :selected_option, :product_type, :quantity)
    end
end
