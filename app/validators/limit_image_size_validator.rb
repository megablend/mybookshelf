###############################################################
# limit_image_size_validator.rb - rails validator
###############################################################
class LimitImageSizeValidator < ActiveModel::EachValidator
  # constants 
  MAXIMAGEFILE = 2

  def validate_each(record, attribute, value)
    if UploadedFile.size_limit_exceeded?(record.send(attribute).file, file_size_limit)
     record.errors[attribute] << "must not be larger than #{file_size_limit} MB"
   end
  end

  private

  def file_size_limit
    options[:max] || MAXIMAGEFILE
  end
end