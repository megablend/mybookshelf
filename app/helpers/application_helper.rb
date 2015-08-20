module ApplicationHelper
	#display page titles
	def page_title(title)
       default_title = "Online Bookstore in Nigeria"
       if title.empty? then default_title else  default_title + ' | ' + title end
	end

	def body_class(class_name)
        if class_name.empty? then nil else "class=' " + class_name + "'" end
	end
end
