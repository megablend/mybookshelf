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
