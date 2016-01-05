module CartHelper
	# cart holding all print book products
	def add_cart(product_id, quantity)
       encrypted_product_id = Base64.encode64(product_id.to_s)
       session[:cart] ||= Hash.new
       session[:cart][encrypted_product_id] = session[:cart][encrypted_product_id].nil? ? quantity : session[:cart][encrypted_product_id].to_i + quantity
	end

    # cart holding all ebook products
    def add_ebook_cart(product_id)
       encrypted_product_id = Base64.encode64(product_id.to_s)
       session[:ebooks_cart] ||= Hash.new
       session[:ebooks_cart][encrypted_product_id] = 1
    end

    def ebook_in_cart?(product_id)
       encrypted_product_id = Base64.encode64(product_id.to_s)
       !session[:ebooks_cart].nil? && session[:ebooks_cart].has_key?(encrypted_product_id)
    end
    
    # cart title
    def cart_title
      total_items_in_cart = !session[:cart].nil? ?  session[:cart].length : 0
      total_ebooks_items_in_cart = !session[:ebooks_cart].nil? ? session[:ebooks_cart].length : 0
      item_pluralize = (total_items_in_cart + total_ebooks_items_in_cart) == 1 ? "Item" : "Items"
      if session[:cart].nil? && session[:ebooks_cart].nil? then "0 - Items" else "#{total_items_in_cart + total_ebooks_items_in_cart} #{item_pluralize}" end
	end

	def get_sub_total
       cart_total = 0
       ebook_cart_total = 0

       if !shopping_cart_empty?
          if any_products_in_cart?
             products_in_cart.each do|key, item|
                product = Product.find(Base64.decode64(key).chomp.to_i)
                cart_total += BigDecimal.new(product.price.to_s) * BigDecimal.new(item.to_s)
             end
          end

          if any_ebooks_in_cart?
             ebooks_in_cart.each do|key, item|
                product = Product.find(Base64.decode64(key).chomp.to_i)
                ebook_cart_total += BigDecimal.new(product.ebook_price.to_s) * BigDecimal.new(item.to_s)
             end
          end
       end

       # total subtotal
       cart_total + ebook_cart_total
	end

	def process_delete_cart_item(product_type, product_id)
       encrypted_product_id = Base64.encode64(product_id.to_s)
       item = (product_type == "print_book") ? session[:cart] : session[:ebooks_cart]
       delete_cart_item(item, encrypted_product_id)
	end

	def delete_cart_item(item, key)
       if !item.nil? && item.class == Hash
       	  item.delete(key) if item.has_key?(key)
       end
	end

	def shopping_cart_empty?
       return true if session[:cart].nil? && session[:ebooks_cart].nil? 
	end

	def shopping_cart_hash_empty?
		if !shopping_cart_empty?
           return true if session[:cart].empty? && session[:ebooks_cart].empty? 
        end
	end

	def products_in_cart
       session[:cart]
	end

	def ebooks_in_cart
      session[:ebooks_cart]
	end

	def any_products_in_cart?
		!session[:cart].nil?
	end

	def any_ebooks_in_cart?
       !session[:ebooks_cart].nil?
	end
end
