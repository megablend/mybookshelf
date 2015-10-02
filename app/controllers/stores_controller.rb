class StoresController < ApplicationController

    # Load Merchants Helper
    include MerchantsHelper

	# store index page
	def index

	end

	# create a new store
	def create
       # render plain: "working"
       @store = Store.new(store_params)
       @store.merchant_id = session[:merchant_id]
	   if(@store.save)
	         # set active session and render the email verification page
	         start_registration_step "verify_email"
	         process_registration_steps "store_details"

	         # get merchant details 
	         @merchant = Merchant.find(session[:merchant_id])

	         # send a verification email to this merchant

	         logger.debug "Steps: #{current_step}"
	         logger.debug "Steps: #{session[:steps]}"
	         render 'merchants/new'
	   else
	       render 'merchants/new'
	   end
	end

	# permit only a defined number of values to be passed from the web form
  private

	  def store_params
	     params.require(:store).permit(:name, :description, :url, :store_type_id)
	  end
end