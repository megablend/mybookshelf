class StoresController < ApplicationController

    # Load Merchants Helper
    include MerchantsHelper

	# store index page
	def index
       # check the regisgration is still going on
       if(step_active?)
           redirect_to '/merchants/signup'
       else
       	render plain: "index of stores"
       end
	end

	# create a new store
	def create
       @store = Store.new(store_params)
       @store.merchant_id = session[:merchant_id]
	   if(@store.save)
	   	     # set active session and render the email verification page
	         start_registration_step "verify_email"
	         process_registration_steps "store_details"
	         
	         # logger.debug "This is the current active step: #{session[:active_step]} and steps #{session[:steps]}"

	   	     # send an email verification mail to merchant
	         @merchant = Merchant.find(session[:merchant_id])# get merchant details 
	         MerchantsMailer.registration_email(@merchant).deliver_later

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