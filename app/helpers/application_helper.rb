module ApplicationHelper
	#display page titles
	def page_title(title)
       default_title = "MyBookshelf Nigeria"
       if title.empty? then default_title else  default_title + ' - ' + title end
	end

	def home_page_title(title)
       default_title = "Online Bookstore in Nigeria"
       if title.empty? then default_title else  default_title + ' | ' + title end
	end

	def body_class(class_name)
        if class_name.empty? then nil else class_name  end
	end

	# get the active breadcrumb 
	def product_breadcrumb?(product=nil)
		!product.empty?
	end

	def breadcrumb(current_page)
        if current_page.empty? then nil else current_page end
	end

	# get breadcrumb category
	def breadcrumb_category(category)
		if category.empty? then nil else category end
	end
    
    # get breadcrum product detail
	def breadcrumb_product_detail(product_detail)
		if product_detail.empty? then nil else product_detail end
	end

	# capitalize strings
	def capitalize_string(string)
        string.downcase.split(" ").map(&:capitalize).join(" ")
	end

	# Company Details
	def company_details
      company = CompanyProfile.find(1)
	end

	# get product category
	def get_product_category(product_id)
       product = Product.find(product_id)
       product.category.name
	end
end
