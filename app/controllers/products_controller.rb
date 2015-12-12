class ProductsController < ApplicationController

	# Load Merchants Helper
    include ProductsHelper

	# merchants products list
	def index

	end

    # add a new product
	def create

	end

	# add a temporary books description
	def description
		# has this merchant uploaded an epub file yet?
		if is_ebook_options_selected?(description_params[:products_type_id]) && !temporary_epub_session_active?
        	@epub_not_uploaded = true

        	# respond to js and html
	        respond_to do|format|
	           format.js
	           format.html
	        end
	        return
		end
      
      # Process form data
      check_member_details = TemporaryProductsDescription.find_by(merchant_id: session[:merchant_id])
      @temporary_products = if check_member_details != nil then check_member_details else TemporaryProductsDescription.new(description_params) end

      if check_member_details.nil?
         # save book description details temporarily
         @temporary_products.add_merchant_id = session[:merchant_id]
         if @temporary_products.save
         	activate_temporary_book_desc_session @temporary_products.id
         else
           @error = true
         end
      else
      	 # update previous record to save space
      	 if @temporary_products.update(description_params)
      	 	activate_temporary_book_desc_session @temporary_products.id
      	 else
      	 	@error = true
      	 end
      end

      # respond to js and html
      respond_to do|format|
         format.js
         format.html
      end
	end

	# upload a cover image for a title
	def upload_cover_image
       
	end

	# upload epub file
	def upload_epub_file
       temporary_upload_params = { upload_type: "epub file", file_name: params[:file], merchant_id: session[:merchant_id] }

       # check if a record of the active mechant exists in the temporary uploads table
       check_member_details = TemporaryUpload.find_by(merchant_id: session[:merchant_id], upload_type: "epub file")
       @epub_file = if check_member_details != nil then check_member_details else TemporaryUpload.new temporary_upload_params end

       if check_member_details.nil?
       	  if @epub_file.save
	         activate_temporary_epub_session @epub_file.id
	         respond_to do|format|
	            format.json {render :json => @epub_file}
	         end
	      else
	       	  respond_to do|format|
	            format.json {render :json => { message: @epub_file.errors.full_messages.join(', ')}, :status => 200 }
	          end
	      end
       else
          if @epub_file.update(temporary_upload_params)
	         activate_temporary_epub_session @epub_file.id
	         respond_to do|format|
	            format.json {render :json => @epub_file}
	         end
	      else
	       	  respond_to do|format|
	            format.json {render :json => { message: @epub_file.errors.full_messages.join(', ')}, :status => 200 }
	          end
	      end
       end
	end

	private
	  def description_params
         params.require(:book_description).permit(:products_type_id, :title, :isbn, :vat_option_id, :price, :special_price, :description, :quantity, :product_protected)
	  end
end
