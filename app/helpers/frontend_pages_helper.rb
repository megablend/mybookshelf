module FrontendPagesHelper
	def product_javascript_function(product_type, product_name, product_id, quantity)
       case product_type
       when "Print Book" then return "cart.addCart('print_book','#{product_id}', '#{quantity}')"
       when "Ebook" then return "cart.addCart('ebook', '#{product_id}', '1')"
       when "Print and Ebook" then return "cart.chooseProduct('#{product_id}', '#{product_name}')"
       else
          return "cart.addCart('#{product_id}', '#{quantity}')"
       end
	end
end
