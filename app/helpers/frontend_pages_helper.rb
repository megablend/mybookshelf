module FrontendPagesHelper
	def product_javascript_function(product_type, product_name, product_id, quantity)
       case product_type
       when "Print Book" then return "cart.addCart('print_book','#{product_id}', '#{quantity}')"
       when "EBook" then return "cart.addCart('ebook', '#{product_id}', '1')"
       when "Print and EBook" then return "cart.chooseProduct('#{product_id}', '#{product_name}')"
       else
          return "cart.addCart('#{product_id}', '#{quantity}')"
       end
	end

	# product page
	def single_product_javascript_function(product_type, product_id, quantity)
		case product_type
	       when "Print Book" then return "cart.addCart('print_book','#{product_id}', '#{quantity}')"
	       when "EBook" then return "cart.addCart('ebook', '#{product_id}', '#{quantity}')"
	       when "Print and EBook" then return "cart.addSingleProduct('#{product_id}', '#{quantity}')"
	       else
	          return "cart.addCart('#{product_id}', '#{quantity}')"
	    end
	end

	def available_stock(quantity)
       if quantity.to_i > 0 then "In Stock" else "Out of Stock" end
	end

	# get the average number of ratings
	def ratings(number_of_reviews)
		return true if number_of_reviews > 0
	end
end
