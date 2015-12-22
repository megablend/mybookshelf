class TemporaryEpubUpload < ActiveRecord::Base
 mount_uploader :file_name, TemporaryEpubFileUploader

 validates :file_name, limit_file_size: true
end