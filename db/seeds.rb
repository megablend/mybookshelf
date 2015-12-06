# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# generate a list of all the states in Nigeria
states_list = ["Abia",
               "Abuja",  
               "Anambra",                
               "Adamawa",                
               "Akwa Ibom",                
               "Bauchi", 
               "Bayelsa",                
               "Benue",                
               "Borno",                
               "Cross River",                
               "Delta",                
               "Edo",                
               "Ekiti", 
               "Ebonyi",                
               "Enugu", 
               "Gombe",  
               "Imo",  
               "Kano",              
               "Lagos",                
               "Nassarawa",
               "Jigawa",         
               "Kebbi",                
               "Kaduna",                
               "Kogi",                
               "Katsina",  
               "Kwara",        
               "Niger",    
               "Ogun",    
               "Ondo",    
               "Osun",                
               "Oyo",      
               "Plateau",           
               "Rivers",      
               "Sokoto",         
               "Taraba",      
               "Yobe",   
               "Zamfara"]
states_list.each do|name|
	state = State.where(name: name)
    State.create(name: name) if !state
end

# Store Types
store_types = ["Print Books Only", "EBooks Only", "Print Books and EBooks"]

store_types.each do|type|
	store_type = StoreType.where(name: type)
   StoreType.create(name: type) if !store_type
end

# Add Default Company Profile details'
company_profiles = {name: "MyBookshelf Limited", 
                    address: "23a, Sura Mogaji, Off Coker Road, Ilupeju Lagos",
                    email: "support@mybookshelf.com.ng",
                    telephone: "08060108165",
                    facebook_profile: "http://www.facebook.com/mybookshelf.ng",
                    twitter_profile: "http://www.twitter.com/mybookshelf.ng",
                    google_plus_profile: "http://www.googleplus.com/mybookshelf.ng",
                    youtube_profile: "http://www.youtube.com/mybookshelf.ng",
                    bbm_profile: "CR535636"}
CompanyProfile.create(company_profiles)

# Seed Categories Data
Dir.glob(Rails.root.join("db/seed_files/*.txt")) do|dir_file|

     File.open(dir_file) do|file|
         file.each do|line|
            name, parent_id, position, level, children_count = line.chomp.split(/\s*\|\s*/) # get the line details, remove end of line and split with the pipe(|) symbol
            name.squeeze!(" ")
            get_category = Category.where(name: name, parent_id: parent_id, position: position, level: level, children_count: children_count)
            Category.create(name: name, parent_id: parent_id, position: position, level: level, children_count: children_count) if !get_category
         end
     end
end

# Product Types
product_types = ["Print Book", "EBook", "Print and EBook"]
product_types.each do|type|
   ProductType.create(product_type: type)
end

# VAT Options 
vat_options = ["5%", "Exempt"]
vat_options.each do|vat|
   VatOption.create(name: vat, status: 1)
end

# File.open(Rails.root.join("db/seed_files/seed_categories.txt")) do|file|
#     file.each do|line|
#        name, parent_id, position, level, children_count = line.chomp.split(/\s*\|\s*/) # get the line details, remove end of line and split with the pipe(|) symbol
#        Category.create(name: name, parent_id: parent_id, position: position, level: level, children_count: children_count)
#     end
# end
