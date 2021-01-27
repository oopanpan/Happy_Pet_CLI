class User < ActiveRecord::Base
    has_many :routines
    has_many :pets, through: :routines

    def add_pet_by_prompt
        puts "What's your pet's name?"
        name = gets.chomp.capitalize
        puts "What's their species?"
        species = gets.chomp.downcase
        puts "What's their age?"
        age = gets.chomp.to_i
        Pet.create(name: name, species: species, age: age)
    end
    
    def pets_by_name
        self.pets.map{|pet| pet.name}.uniq
    end
    
    #all routines for one pet
    def all_routines(pet)
        self.routines.where(pet_id: pet.id)
    end
    
    def all_routines_by_name(pet)
        all_routines(pet).map{|r| r.name}
    end
    #returning list of routines for input pet object
    def finished_routines(pet)
        self.routines.where(pet_id: pet.id, if_complete: true)
    end

    def todo_routines(pet)
        self.routines.where(pet_id: pet.id, if_complete: false)
    end
    

    def user_input(user, input)
        case input
        when "1"
            add_pet(user)  
        when "2"
            view_pet(user)
        when "0"
            exit 
        else 
            print "#{input} INVALID OPTION. PLEASE REVIEW THE MENU OPTIONS. \n\n"
            menu_option(user)
        end
    end








end