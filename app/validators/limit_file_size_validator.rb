###############################################################
# limit_file_size_validator.rb - rails validator
###############################################################
class LimitFileSizeValidator < ActiveModel::EachValidator
  # constants 
  MAXEPUBFILE = 300

  def validate_each(record, attribute, value)
    if UploadedFile.size_limit_exceeded?(record.send(attribute).file, file_size_limit)
     record.errors[attribute] << "must not be larger than #{file_size_limit} MB"
   end
  end

  private

  def file_size_limit
    options[:max] || MAXEPUBFILE
  end
end