=begin
  Author: Megafu Charles Nonso
  Package: Lib
  Description: Process Temporary Uploaded Files
  Date: 20th December 2015
=end

class ProcessTemporaryFiles

   # get the extension of file
   def self.get_file_extension(url)
       File.extname url
   end

   def self.get_file_name(url)
      File.basename url
   end

   def self.copy_file(source_file, destination)
	  FileUtils.mkdir_p destination if !File.directory?(destination)
      FileUtils.cp source_file, destination
   end

   def self.rename_file(old_name, new_name)
      File.rename old_name, new_name if File.exists?(old_name)
   end

   def self.delete_file(url)
      File.delete if File.exists?(url)
   end
end