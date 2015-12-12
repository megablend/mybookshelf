module ProductsHelper

	# active temporary epub upload session
	def activate_temporary_epub_session(temporary_file_id)
      session['epub_id'] = temporary_file_id
	end

	def temporary_epub_session_active?
       !session['epub_id'].nil?
	end

	# check if ebook options were selected
	def is_ebook_options_selected?(option)
       return true if option == "2" || option == "3"
	end

	# activate temporary book description session
	def activate_temporary_book_desc_session(book_description_id)
       session[:book_description_id] = book_description_id
	end
end
