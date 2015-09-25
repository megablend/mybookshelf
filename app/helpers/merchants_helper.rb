module MerchantsHelper
	def current_step
        if step_active?
            case session[:active_step]
            when "store_details" then "store_details"
            when "verify_email" then "verify_email"
            else
                "complete_registration"
            end
        else
            "merchant_details"
        end
	end

	def step_active?
       !!session[:active_step]
	end
end
