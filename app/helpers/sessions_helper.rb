module SessionsHelper

	# login a new merchant
	def log_in(merchant)
       session[:merchant_id] = merchant.id
	end

	def is_merchant_logged_in?
       !session[:merchant_id].nil?
	end

	def current_merchant
		@current_merchant ||= Merchant.find(session[:merchant_id])
	end

    # Returns true if the merchant completed the second stage of his registration
	def provided_store_details?(merchant)
       store = Store.find_by(merchant_id: merchant.id)
       store
	end

    # Returns true if the  merchant's email address is verified
	def is_merchant_email_verified?(email)
       true if email == 1
	end

	# Returns true if the user is logged in, false otherwise.
	def logged_in?
	    !current_merchant.nil?
	end

	# logs out the current merchant
	def logout
       session.delete(:merchant_id)
       @current_merchant = nil
	end
end
