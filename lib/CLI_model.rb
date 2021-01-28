class CommandLineInterface
    
    #*************************
    #INTERFACE
    #*************************
    #get user input, return the imput content
    def user_name_input
        gets.chomp
    end
    #display greeting message
    def display_greeting_message
        puts "Welcome to This App"
        puts "Please enter your name:"
    end
    
    def top_menu
        puts "What would you like to do? Please select by number"
            puts "[1] Add a new pet"
            puts "[2] View all of your pet(s)"
            puts "[3] Say goodbye to a pet"
            puts "[0] Quit"
        end
        
    def top_menu_selection(user, input)
        case input
        when "1"
            pet = user.add_pet_by_prompt
            puts "\n***#{pet.name}*** is a lovely cutie.\nPlease take good care of them!\n"
            pet
        when "2"
            if user.pets == []
                puts "Interesting, you don't seem to own any pet.\n"
                sleep(3)
                false
            else
                puts "\nHere is the list of your pet(s), please select by number."
                display_array_with_number(user.pets_by_name)
                pet = pets_selector(user, gets.chomp.to_i)
            end
        when "3"
            array = user.pets_by_name
                if array == []
                    puts "Interesting, you don't seem to own any pet.\n"
                    sleep(3)
                    false
                else
                    puts "Which pet would you like to say goodbuy? Pleasee Select by number"
                    display_array_with_number(array)
                    pet = pets_selector(user, gets.chomp.to_i)
                    puts "Goodbye #{pet.name} we'll miss you!"
                    pet.destroy
                    Routine.delete_routines_with_no_pet
                    false
                end
        when "0"
            puts "\nGOODBYE! HAVE A PRODUCTIVE DAY!\n"
            exit
        else 
            print "\n#{input} INVALID OPTION. PLEASE REVIEW THE MENU OPTIONS."
        end
    end
        
    def routine_menu
        puts "Press [1] to ADD ROUTINE!"
        puts "Press [2] to VIEW ALL ROUTINE!"
        puts "Press [0] to GO BACK TO LAST MENU! "
    end
        
    def routine_user_input(user, pet, input)
        case input
        when "1"
            pet.add_routine(user)
        when "2"
            puts "\nPlease select a routine by number:"
            display_array_with_number(user.all_routines_by_name(pet))
        when "0"
            $in_pet_menu = false
        else 
            print "****#{input} INVALID OPTION. PLEASE REVIEW THE MENU OPTIONS. \n\n****"
            routine_menu
        end
    end

    def routine_sub_menu(routine)
        puts "Enter [1] to COMPLETE ROUTINE."
        puts "Enter [2] to EDIT/DELTE ROUTINE."
        input = gets.chomp
        case input
            when "1"
                puts "\nRoutine: #{routine.name}\n#{routine.description}\n\nIs this routine finish? Y/N"
                complete = gets.chomp
                if complete == "Y"
                    routine.if_complete = true
                end
            when "2"
                routine.edit_routine_by_prompt
            when "0"
                $in_routine_menu = false
                false
            else 
                print "#{input} INVALID OPTION. PLEASE REVIEW THE MENU OPTIONS. \n\n"
                routine_menu
        end
    end
        
    
    #display main menu, take in an user object, display all the dog
    #in the database
    def display_all_pets_by_name
        arr = Pet.all.map{|pet| pet.name}
    end
    
    def display_array_with_number(array)
        array.each_with_index{|element,i| puts "[#{i+1}] #{element}"}
    end
    
    #display the routines needs to be done for the dog 
    def display_routines(user, dog)
        user.routines.where(pet_id: pet.id)
    end
    #****************
    #User
    #****************
    #
    #*******************
    #Pet
    #*******************
    def add_pet_by_prompt
        puts "What's your pet's name?"
        name = gets.chomp.capitalize
        puts "What's their species?"
        species = gets.chomp.downcase
        puts "What's their age?"
        age = gets.chomp.to_i
        Pet.create(name: name, species: species, age: age)
    end
    
    def pets_selector(user, number)
        pet_name = user.pets_by_name[number-1]
        Pet.find_by(name:pet_name)
    end
    
    #*************************
            #Routine    
    #*************************


    # def add_routine_by_prompt(user, pet)
    #     puts "\n\nCongratulations on your new pet"
    #     puts "What's the name of the routine"
    #     name = gets.chomp.capitalize
    #     puts "Description of the routine"
    #     description = gets
    #     Routine.create(name: name, description: description, user_id: user.id, pet_id: pet.id )
    # end

    #find the singular routine object
    def routine_selector(name, user, pet)
        Routine.find_by(name: name, user_id: user.id, pet_id: pet.id)
    end


    




    def run
        $running = true
        while $running do
            display_greeting_message
            user = User.find_or_create_by(name: user_name_input)
            while user do
                puts "\nWelcome, #{user.name}\n"
                top_menu
                pet = top_menu_selection(user, gets.chomp)
                $in_pet_menu = true
                while $in_pet_menu && pet do
                    puts "\nThis is #{pet.name}'s Routine menu"
                    routine_menu
                    proceed = routine_user_input(user, pet, gets.chomp)
                    if proceed
                        routine_name = user.all_routines_by_name(pet)[gets.chop.to_i-1]
                        routine = routine_selector(routine_name, user, pet)
                        routine_sub_menu(routine)
                    end

                    # if routine
                    #     $in_routine_menu = true
                    # end
                    
                    
                end
            end

            routine.edit_routing_by_prompt
            puts "Hello"


        
        end

        exit_message
    end







    # def run 
    #     user = greet 
    #     self.menu_option(user)
    # end

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

    

    
    #this method helps user to create a pet, returning pet instance 

    def add_pet(user)
        puts "\n\nTo add a pet, Please enter the pet name: "
        input = STDIN.gets.chomp()
        new_pet = Pet.new(name:input)
        puts "Please enter #{input} species: "
        new_pet.species = STDIN.gets.chomp()
        puts "Please enter #{input} age: "
        new_pet.age = STDIN.gets.chomp()
        new_pet.save
        puts "Pet #{input} created!"
        add_routine(user)
    end

    #add a new routine for the pet


    def view_current_routine(user, pet)
        #Routine.find_by(user_id:user.id, pet_id:pet.id)
        puts "\n\nPlease select from the following current routines:"
        Routine.all.each do |routine| 
            puts routine.name
        end
    end


 

end
