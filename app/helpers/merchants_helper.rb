module MerchantsHelper

    # Start the registration step
    def start_registration_step(step)
        session[:active_step] = step
    end

    # get the active merchant id
    def active_merchant_id(user)
        session[:temporary_merchant_id] = user.id
    end

    # get the class of the active
    def get_active_step_class(navigation)
        class_name = "active"
        if step_active?
            if current_step == navigation || (!session[:steps].nil? && session[:steps].uniq.include?(navigation)) then class_name else nil end
        else
            if navigation == "merchant_details" then class_name else nil end
        end
    end

    def steps_session(step=nil)
       session[:steps] = [] if session[:steps].nil?
       session[:steps] << step unless step.nil? 
    end

    # list of processed steps
    def process_registration_steps(step)
        steps_session step
    end

    # detect the current registration step
	def current_step
        if step_active?
            case session[:active_step]
            when "store_details" then "store_details"
            when "verify_email" then "verify_email"
            else
                "merchant_details"
            end
        else
            "merchant_details"
        end
	end

    # generate random string
    def generate_random_string(maximum_number)
        SecureRandom.base64(maximum_number).delete('/+=')[0, maximum_number]
    end

    # check if the current step is active
	def step_active?
       !session[:active_step].nil?
	end

    # check if the merchant session is set
    def merchant_session_active?
       !session[:temporary_merchant_id].nil?
    end

    # complete merchant registration
    def completed_registration?
          if step_active? && current_step == "verify_email" && merchant_session_active?
              # check if the merchant email has been verified
              merchant = Merchant.find(session[:temporary_merchant_id])

              if merchant.email_verified == 1
                 reset_active_step_session # reset sessions
                 return true
              end
          end
          false
    end

    def complete_registration(merchant)
        merchant.complete_registration
    end

    # reset active step session
    def reset_active_step_session
        session.delete(:active_step)
        session.delete(:temporary_merchant_id)
        session.delete(:steps)
    end
end
