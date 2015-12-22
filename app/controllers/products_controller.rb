class ProductsController < ApplicationController

	# Load Merchants Helper and Products Helper
    include ProductsHelper
    include MerchantsHelper

	# merchants products list
	def index

	end

    # add a new product
	def create

	end

	# Complete Products Upload
	def complete_upload
	   temporary_products_desc = TemporaryProductsDescription.find(session[:book_description_id])
       cover_image = TemporaryUpload.find(session[:cover_image_id])

	   # add product to the products table
	   resource_id = SecureRandom.hex(8)
       product = Product.new(get_product(temporary_products_desc, resource_id))
       if !product.save
          @error = true
            # respond to js and html
	        respond_to do|format|
	           format.js
	           format.html
	        end
	        return
       end

       # add product description
       product_description = ProductsDescription.new(get_product_description(temporary_products_desc, product.id))
       if !product_description.save
          @error = true
            # respond to js and html
	        respond_to do|format|
	           format.js
	           format.html
	        end
	        return
       end

       # Category
       product_category = Category.new({product_id: product.id, category_id: session[:selected_sub_category]})
       if !product_category.save
          @error = true
            # respond to js and html
	        respond_to do|format|
	           format.js
	           format.html
	        end
	        return
       end

       # Cover Image 
       source = "#{Rails.public_path}#{cover_image.file_name.url}" # copy image 
       destination = "#{Rails.public_path}/uploads/products_image/image/#{product.id}"
       ProcessTemporaryFiles.copy_file source, destination

       old_file_name = "#{Rails.public_path}/uploads/products_image/image/#{product.id}/#{ProcessTemporaryFiles.get_file_name(cover_image.file_name.url)}"
       new_file_name = "#{Rails.public_path}/uploads/products_image/image/#{product.id}/cover_image_#{SecureRandom.hex(8)}#{ProcessTemporaryFiles.get_file_extension(cover_image.file_name.url)}"
       product_image_url = "/uploads/products_image/image/#{product.id}/cover_image_#{SecureRandom.hex(8)}#{ProcessTemporaryFiles.get_file_extension(cover_image.file_name.url)}"
       ProcessTemporaryFiles.rename_file old_file_name, new_file_name

       # add product image
       product_image_hash = { product_id: product.id, image: product_image_url }
       product_image = ProductsImage.new(product_image_url)
       if !product_image.save
         @error = true
            # respond to js and html
	        respond_to do|format|
	           format.js
	           format.html
	        end
	        return
       end

       # # process epub data and move uploaded file to the products_ebooks folder
       # if temporary_epub_session_active?
       #     epub_file = TemporaryEpubUpload.find(session[:epub_id])
       # end
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
       temporary_upload_params = { upload_type: "cover image file", file_name: params[:file], merchant_id: session[:merchant_id] }
       # check if a record of the active mechant exists in the temporary uploads table
       check_member_details = TemporaryUpload.find_by(merchant_id: session[:merchant_id], upload_type: "cover image file")
       @cover_image_file = if check_member_details != nil then check_member_details else TemporaryUpload.new temporary_upload_params end

       	if check_member_details.nil?
           if @cover_image_file.save 
           	 activate_temporary_cover_image_session @cover_image_file.id
           	 respond_to do|format|
               format.json { render :json => @cover_image_file }
           	 end
           else
              respond_to do|format|
		         format.json {render :json => { message: @cover_image_file.errors.full_messages.uniq!.join(', ')}, :status => 200 }
		      end
           end
       	else
       		if @cover_image_file.update(temporary_upload_params)
	           activate_temporary_cover_image_session @cover_image_file.id
	           respond_to do|format|
	              format.json {render :json => @cover_image_file}
	           end
	        else
	       	   respond_to do|format|
	             format.json {render :json => { message: @cover_image_file.errors.full_messages.join(', ')}, :status => 200 }
	           end
	        end
       	end
	end

	# upload epub file
	def upload_epub_file
       temporary_upload_params = { file_name: params[:file], merchant_id: session[:merchant_id] }

       # check if a record of the active mechant exists in the temporary uploads table
       check_member_details = TemporaryEpubUpload.find_by(merchant_id: session[:merchant_id])
       @epub_file = if check_member_details != nil then check_member_details else TemporaryEpubUpload.new temporary_upload_params end

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
         params.require(:book_description).permit(:products_type_id, :title, :author, :publisher, :publish_date, :isbn, :vat_option_id, :price, :special_price, :description, :quantity, :product_protected)
	  end

	  def get_product(temporary_products_desc, resource_id)
           product = { isbn_number: temporary_products_desc.isbn,
           	           resource_id: resource_id,
		   	           quantity: temporary_products_desc.quantity, 
		   	           merchant_id: temporary_products_desc.merchant_id,
		   	           products_type_id: temporary_products_desc.products_type_id,
		   	           price: temporary_products_desc.price,
		   	           special_price: temporary_products_desc.special_price,
		   	           status: 1,
		   	           vat_option_id: temporary_products_desc.vat_option_id }
	   	   return product
	  end

	  def get_product_description(description, product_id)
         product_description = { title: description.title,
                                 author: description.author,
                                 description: description.description,
                                 product_id: product_id,
                                 publisher: description.publisher,
                                 publish_date: description.publish_date,
                                 tag: description.title,
                                 meta_title: description.title,
                                 meta_description: description.title,
                                 meta_keyword: description.title}
         return product_description
	  end

	  def delete_temporary_data
         TemporaryEpubUpload.where(id: session[:epub_id]).destroy_all unless session[:epub_id]
         TemporaryProductsDescription.where(id: session[:book_description_id]).destroy_all unless session[:book_description_id]
         TemporaryUpload.where(id: session[:cover_image_id]).destroy_all unless session[:cover_image_id]

         # delete all active sessions 
         delete_sell_a_book_temporary_sessions
	  end
end
