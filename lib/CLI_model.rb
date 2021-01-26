class CommandLineInterface

    def run 
        user = greet 
        self.menu_option(user)
    end

    def greet 
        puts "Welcome to PanSin Pet Routine Checker"
        puts "Please enter your name: "
        input = STDIN.gets.chomp()
        user = User.find_or_create_by(name:input)
    end

    def menu_option(user)
        puts "Press 1 to ADD PETS!"
        puts "Press 2 to VIEW PETS!"
        puts "Press 0 to exit! "
        input = STDIN.gets.chomp()
        puts self.user_input(user, input)
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

    def exit 
        "\n\nGOODBYE! HAVE A PRODUCTIVE DAY!"
    end
    
    #this method helps user to create a pet, returning pet instance 

    def add_pet(user)
        puts "\n\nTo add a pet, Please enter the pet name: "
        input = STDIN.gets.chomp()
        new_pet = Pet.new(name:input)
        new_pet.user_id = self.id
        put "Please enter #{input} species: "
        new_pet.species = STDIN.gets.chomp()
        puts "Please enter #{input} age: "
        new_pet.age = STDIN.gets.chomp()
        new_pet.save
        puts "Pet #{input} created!"
        add_routine(user)
    end

    def add_routine(user)
        puts "\n\nPlease add a routine: "
        input = STDIN.gets.chomp()
        new_routine = Routine.new(name:input)
        puts "Please enter #{input} description: "
        new_routine.description = STDIN.gets.chomp()
        puts "Pet #{input} routine created!"
        routine_menu_option(user)
    end

    def view_current_routine(pet,user)
        Routine.find_by(user_id:user.id, pet_id:pet.id)
    end


    def routine_menu_option(user)
        puts "Press 1 to ADD ROUTINE!"
        puts "Press 2 to VIEW ALL ROUTINE!"
        puts "Press 0 to exit! "
        input = STDIN.gets.chomp()
        puts self.routine_user_input(user, input)
    end

    def routine_user_input(user, input)
        case input
        when "1"
            add_routine(user)  
        when "2"
            view_current_routine(user)
        when "0"
            exit 
        else 
            print "#{input} INVALID OPTION. PLEASE REVIEW THE MENU OPTIONS. \n\n"
            routine_menu_option(user)
        end
    end
 
    
    def view_pet(user)

    end

end