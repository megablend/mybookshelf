class MerchantsController < ApplicationController
  
  # dashboard
  def index

  end
   
  # signup page 
  def new
  	 @merchant = Merchant.new
  end

  # create a new merchant's account
  def create
     @merchant = Merchant.new(merchant_params)
     if(@merchant.save)
         # set active session and render the merchant page with store details form
         session[:active_step] = "store_details"
         session[:merchant_id] = @merchant.id
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
