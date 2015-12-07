class TemporaryUpload < ActiveRecord::Base
   mount_uploader :file_name, TemporaryEpubFileUploader # mount the new file
end