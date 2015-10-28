class SessionsController < ApplicationController

  # Load Merchants Helper
  include MerchantsHelper

  def new
  end

  # login a new merchant
  def create
     merchant = Merchant.find_by(email: params[:session][:email].downcase)
     if merchant && merchant.authenticate(params[:session][:password])
     	 # check if this merchant provided his/her store details
     	 if !provided_store_details?(merchant)
     	 	# set active session and render the merchant page with store details form
	        start_registration_step "store_details"
	        active_merchant_id merchant
	        process_registration_steps "merchant_details"
     	 	  flash.now['danger'] = "You did not complete step two of your registration (Merchant Store Details). 
     	 	                         Please click on this <a href='/merchants/signup'>link</a> to continue"
     	 	  render 'new'
     	 elsif !is_merchant_email_verified?(merchant.email_verified)
     	 	# set active session and render the merchant page with store details form
	        start_registration_step "verify_email"
	        active_merchant_id merchant
	        process_registration_steps "merchant_details"
	        process_registration_steps "store_details"
     	 	  flash.now['danger'] = "Your email address is not yet verified, please visit your inbox or click <a href='/merchants/signup'>here</a> for a new verification request"
     	 	  render 'new'
         else
         	  log_in merchant # log in the existing merchant
            redirect_to '/merchants'
         end
     else
     	   flash.now['danger'] = 'Invalid Email/Password provided, please try again.'
         render 'new'
     end
  end

  # logout a merchant
  def destroy
     logout if logged_in?
     redirect_to '/merchants/login'
  end
end
