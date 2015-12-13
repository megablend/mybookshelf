class TemporaryUpload < ActiveRecord::Base
   attr_accessor :get_upload_type
   # contant variables
   MAXEPUBFILE = 300
   MAXIMAGEFILE = 2

   mount_uploader :file_name, TemporaryEpubFileUploader, if: :is_epub_file # mount the new 
   mount_uploader :file_name, ProductsImagesUploader, if: :is_epub_file # mount the new 
   validate :epub_max_file_size, if: :is_epub_file
   validate :cover_image_file_size, if: :is_cover_image

   def test_upload_type
     logger.debug "The upload type: " + self.get_upload_type if !self.get_upload_type.nil?
   end

   def is_epub_file
      return true if self.get_upload_type == "epub file"
   end

   def is_cover_image
     return true if self.get_upload_type == "cover image file"
   end

   def epub_max_file_size
      if file_name.file.size.to_f/(1000 * 1000) > MAXEPUBFILE
      	errors.add(:file_name, "must not be greater than #{MAXEPUBFILE}MB")
      end
   end

   def cover_image_file_size
      if file_name.file.size.to_f/(1000 * 1000) > MAXIMAGEFILE
         errors.add(:file_name, "must not be greater than #{MAXIMAGEFILE}MB")
      end
   end
end