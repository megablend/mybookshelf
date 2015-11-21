class MerchantsController < ApplicationController
  # macro-style callback actions
  before_action :validate_merchant, only: [:index, :sell]
  
  # Load Merchants Helper
  include MerchantsHelper
  include CategoriesHelper
  
  # dashboard
  def index
     # logger.debug Rails.root.join("db/seed_files/seed_categories.txt")
     @merchant = Merchant.find(session[:merchant_id])
     @fullname = "#{@merchant.firstname.downcase.capitalize} #{@merchant.lastname.downcase.capitalize}" 
     render layout: 'merchants/merchants'
     return
  end

  # Sell a book
  def sell
     @categories = Category.where(parent_id: 0).order(:name)
     @merchant = Merchant.find(session[:merchant_id])
     @fullname = "#{@merchant.firstname.downcase.capitalize} #{@merchant.lastname.downcase.capitalize}" 
     render layout: 'merchants/merchants'
     return
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
         return
     else
       render 'new'
       return
     end
  end

  # resend email verification mail to merchant
  def resend_mail
      if step_active? && merchant_session_active?
          # send an email verification mail to merchant
          @merchant = Merchant.find(session[:temporary_merchant_id])# get merchant details 
          MerchantsMailer.registration_email(@merchant).deliver_later
          render 'new'
          return
      else
         redirect_to root_path
         return
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
        return
     end
  end


  # permit only a defined number of values to be passed from the web form
  private

	  def merchant_params
	     params.require(:merchant).permit(:firstname, :lastname, :phone_number, :email, :address, :city, :landmark, :state_id, :password, :password_confirmation, :terms)
	  end
    
    # redirect a merchant to the login page if they don't have access
    def validate_merchant
         redirect_to merchants_login_path unless is_merchant_logged_in?
    end
end
