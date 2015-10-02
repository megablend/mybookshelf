class MerchantsController < ApplicationController

  # Load Merchants Helper
  include MerchantsHelper
  
  # dashboard
  def index

  end
   
  # signup page 
  def new
     # reset_active_step_session # temporary reset session
  	 @merchant = Merchant.new
     @store = Store.new
     # logger.debug "Verification code: #{session[:active_step]}" 
  end

  # create a new merchant's account
  def create
     @merchant = Merchant.new(merchant_params)
     @merchant.verification_code = generate_random_string 12 # generate an email verification code
     if(@merchant.save)
         # set active session and render the merchant page with store details form
         start_registration_step "store_details"
         active_merchant_id @merchant
         process_registration_steps "merchant_details"
         render 'new'
     else
       render 'new'
     end
  end

  # permit only a defined number of values to be passed from the web form
  private

	  def merchant_params
	     params.require(:merchant).permit(:firstname, :lastname, :phone_number, :email, :address, :city, :landmark, :state_id, :password, :password_confirmation, :terms)
	  end
end
