class User < ActiveRecord::Base
    has_many :routines
    has_many :pets, through: :routines

    #returning list of routines for input pet object
    def finished_routines(pet)
        self.routines.where(pet_id: pet.id, if_complete: true)
    end

    def todo_routines(pet)
        self.routines.where(pet_id: pet.id, if_complete: false)
    end

    def pets_by_name
        self.pets.map{|pet| pet.name}.uniq
    end

    #all routines for one pet
    def all_routines(pet)
        self.routines.where(pet_id: pet.id)
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

    def edit_routine_by_prompt(pet, routine)

    end






end