###############################################################
# uploaded_file.rb - utility class
###############################################################

class UploadedFile
  def self.size(file)
    uploaded?(file) ? file.size : nil
  end

  # NOTE: if I attempt to check the file size without making sure there is a file upload the fog rubygem bombs.
  def self.size_limit_exceeded?(file, file_size_limit)
    puts "UploadedFile.size_limit_exceeded? original_filename=#{original_filename(file)} uploaded=#{uploaded?(file)} file_class=#{file.class.name} file_size_limit=#{file_size_limit} file_size=#{size(file)}"
    uploaded?(file) && size(file) > file_size_limit.megabytes
  end

  # FIXME: There must be a cleaner way to check if a file has been uploaded with Carrierwave
  # NOTE: When the file is uploaded it seems to be an instance of CarrierWave::SanitizedFile and when
  # it is not uploaded it's an instance of CarrierWave::Storage::Fog::File
  def self.uploaded?(file)
    original_filename(file).present?
  end

  def self.original_filename(file)
    if file && file.respond_to?(:original_filename)
      file.original_filename
    else
      nil
    end
  end
end