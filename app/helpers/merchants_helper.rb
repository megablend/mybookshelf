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

    # greets a merchant on a particular time
    def greet
        morning_hours = 0..11
        afternoon_hours = 12..15
        hour = Time.now.hour

        # switch between the current time
        case hour
        when morning_hours then return "Good Morning " # time between 23:00 and 11:00
        when afternoon_hours then return "Good Afternoon " # time between 12:00 and 15:00
        else
            return "Good Evening "
        end
    end

    # Return merchants membership duration
    def membership_duration(date_joined)
         date_joined_timestamp = date_joined.to_time.to_i
         current_date = Time.now.getutc.to_i
         time = current_date - date_joined_timestamp
         # return time

         if time <= 60
            return 'Started'
         elsif 60 < time && time <= 3600 # Minutes
            if (time/60).round == 1
                return 'A Minute'
            else
                return  (time/60).round.to_s + " Minutes"
            end
        elsif 3600 < time && time <= 86400 # Hours
            if (time/3600).round == 1
                return 'An Hour'
            else
                return  (time/3600).round.to_s + " Hours"
            end
        elsif 86400 < time && time <= 604800 # Days
            if (time/86400).round == 1
                return 'A Day'
            else
                return (time/86400).round.to_s + " Days"
            end
        elsif 604800 < time && time <= 2592000
            if (time/604800).round == 1
                return 'A Week'
            else
                return (time/604800).round.to_s + " Weeks"
            end
        elsif 2592000 < time && time <= 29030400 # Months
            if (time/2592000).round == 1
                return 'A Month'
            else
                return (time/2592000).round.to_s + " Months"
            end
        else # Years
            if (time/29030400).round == 1
                return 'A Year'
            else
                return (time/29030400).round.to_s + " Years"
            end
        end
    end

    # Delete Sell a Book temporary sessions
    def delete_sell_a_book_temporary_sessions
      session.delete(:selected_sub_category) unless session[:selected_sub_category].nil?
      session.delete(:epub_id) unless session[:epub_id].nil?
      session.delete(:book_description_id) unless session[:book_description_id].nil?
      session.delete(:cover_image_id) unless session[:cover_image_id].nil?
    end
end
