=begin
  Author: Megafu Charles Nonso
  Package: Lib
  Description: Process Temporary Uploaded Files
  Date: 20th December 2015
=end

class ApplicationLanguages
   # Shopping Cart Languages
   def self.shopping_cart_language(language_type, language_data)
      case language_type
      when "text_success" then return "Success: You have added <strong>#{language_data}</strong> to your shopping cart!"
      when "text_ebook_error" then return "Hi, you already have the ebook <strong>#{language_data}</strong> in your cart!"
      else
      	return "unknown language"
      end
   end
end