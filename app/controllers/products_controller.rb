class ProductsController < ApplicationController

	# Load Merchants Helper
    include ProductsHelper

	# merchants products list
	def index

	end

    # add a new product
	def create

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
       	  logger.debug "New Record"
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
       	  logger.debug "Existing Record"
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
end
