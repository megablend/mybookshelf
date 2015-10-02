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
    State.create(name: name)
end

# Store Types
store_types = ["Print Books Only", "EBooks Only", "Print Books and EBooks"]

store_types.each do|type|
   StoreType.create(name: type)
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
