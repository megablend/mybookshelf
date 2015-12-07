module ProductsHelper

	# active temporary epub upload session
	def activate_temporary_epub_session(temporary_file_id)
      session['epub_id'] = temporary_file_id
	end

	def is_temporary_epub_session_active?
       !session['epub_id'].nil?
	end
end
