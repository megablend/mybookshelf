class MerchantsController < ApplicationController

  # Load Merchants Helper
  include MerchantsHelper
  
  # dashboard
  def index
       # check the registration is still going on
       if(is_merchant_logged_in?)
           # logger.debug Rails.root.join("db/seed_files/seed_categories.txt")
           @merchant = Merchant.find(session[:merchant_id])
           @fullname = "#{@merchant.firstname.downcase.capitalize} #{@merchant.lastname.downcase.capitalize}" 
           render layout: 'merchants/merchants'
       else
           redirect_to merchants_login_path
       end
  end

  # Sell a book
  def sell
       # check the registration is still going on
       if(is_merchant_logged_in?)
           @categories = Category.where(parent_id: 0).order(:name)
           @merchant = Merchant.find(session[:merchant_id])
           @fullname = "#{@merchant.firstname.downcase.capitalize} #{@merchant.lastname.downcase.capitalize}" 
           render layout: 'merchants/merchants'
       else
           redirect_to merchants_login_path
       end
  end

  # Show merchant details
  def show
     render plain: "This is where the user profile will be"
  end
   
  # signup page 
  def new
     # has the merchant completed his registration?
     if completed_registration?
        redirect_to merchants_login_path
     end

  	 @merchant = Merchant.new
     @store = Store.new
     # logger.debug "Registration steps: #{session[:steps]}" 
  end

  # create a new merchant's account
  def create
     @merchant = Merchant.new(merchant_params)
     @merchant.verification_code = generate_random_string 50 # generate an email verification code
     if(@merchant.save)
         # set active session and render the merchant page with store details form
         start_registration_step "store_details"
         active_merchant_id @merchant
         process_registration_steps "merchant_details"

         @store = Store.new
         render 'new'
     else
       render 'new'
     end
  end

  # resend email verification mail to merchant
  def resend_mail
      if step_active? && merchant_session_active?
          # send an email verification mail to merchant
          @merchant = Merchant.find(session[:temporary_merchant_id])# get merchant details 
          MerchantsMailer.registration_email(@merchant).deliver_later
          render 'new'
      else
         redirect_to root_path
      end
  end

  # verify email
  def verify_email
     merchant = Merchant.find_by(verification_code: params[:verification_code])
     if merchant && merchant.email_verified == 0
        @merchant_firstname = merchant.firstname.capitalize
        # complete merchant registration
        complete_registration merchant

        # reset all sessions active
        reset_active_step_session
     else
        redirect_to merchants_login_path
     end
  end


  # permit only a defined number of values to be passed from the web form
  private

	  def merchant_params
	     params.require(:merchant).permit(:firstname, :lastname, :phone_number, :email, :address, :city, :landmark, :state_id, :password, :password_confirmation, :terms)
	  end
end
