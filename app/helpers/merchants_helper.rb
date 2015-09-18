module MerchantsHelper
	def current_step
        if step_active?
            if session[:active_step] == "store_details"
            	"store_details"
            elsif session[:active_step] == "verify_email"
            	"verify_email"
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
