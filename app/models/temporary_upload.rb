class TemporaryUpload < ActiveRecord::Base
   attr_accessor :image_width, :image_height

   mount_uploader :file_name, ProductsImagesUploader

   validates :file_name, limit_image_size: true
   validate :validate_minimum_image_size, if: :attributes_available

   def attributes_available
     return true if !self.image_width.nil? && !self.image_height.nil? && self.image_height != 0 && self.image_width != 0
   end

    # custom validation for image width & height minimum dimensions
	def validate_minimum_image_size
		logger.debug "Image size:" + self.image_width.to_s
	    if self.image_width < 395 && self.image_height < 600
	        errors.add :file_name, "should be 395px by 395px minimum!" 
	    end
	end
end