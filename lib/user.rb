class User < ActiveRecord::Base
    has_many :routines
    has_many :pets, through: :routines

    def self.all_user_names
        self.all.map{|user| user.name}
    end

    def deleting_routines_with_user
        arr = Routine.all.select{|routine| routine.user_id == self.id}
        arr.each{|routine| routine.destroy}
    end

    def add_pet_by_prompt
        puts Rainbow("\nTo add a pet, Please enter the pet name:").orange 
        name = gets.chomp.capitalize
        puts Rainbow("What's their species?").orange
        species = gets.chomp.downcase
        puts Rainbow("What's their age?").orange
        age = gets.chomp.to_i
        Pet.create(name: name, species: species, age: age)
    end
    
    def pets_by_name
        self.pets.map{|pet| pet.name}.uniq
    end

<<<<<<< HEAD
    def pets_hash_by_species
        hash = {}
        self.pets.each{|pet| hash[pet.species] = []}
        hash.each {|key,arr|
            arr.select{|i|
                self.pets.each{|pet|
                    pet.species == key    
                }
            }
        }
=======
    def pets_by_detail
        self.pets.uniq
>>>>>>> master
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
        self.routines.where(pet_id: pet.id, if_complete: nil)
    end

    def todo_routines_by_name(pet)
        todo_routines(pet).map{|r| r.name}
    end

end