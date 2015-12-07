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
       @epub_file = TemporaryUpload.new temporary_upload_params

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
	end
end
