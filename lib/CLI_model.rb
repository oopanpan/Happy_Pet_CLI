class CommandLineInterface
    
    #*************************
    #INTERFACE
    #*************************
    #get user input, return the input content
    def user_name_input
        gets.chomp
    end
    #get the date today in a YYYYMMDD format as integer
    def date_today
        date = Time.now.strftime("%F")
        date.split("-").join.to_i
    end
    #display greeting message
    def display_greeting_message
        puts "Welcome to Happy Pet"
        puts "Please enter your name:"
    end
    
    def top_menu
        puts "What would you like to do? Please select by number"
            puts "Enter [1] Add a new pet"
            puts "Enter [2] View all of your pet(s)"
            puts "Enter [3] Say goodbye to a pet"
            puts "Enter [0] Quit"
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
                    puts "Which pet would you like to say goodbye? Please Select by number."
                    display_array_with_number(array)
                    pet = pets_selector(user, gets.chomp.to_i)
                    puts "We're saying goodbye to #{pet.name},correct? Y/N"
                        ans = gets.chomp
                        if ans == "Y"
                            puts ".."
                            sleep(1)
                            puts "..."
                            sleep(1)
                            puts "Goodbye #{pet.name} we'll miss you!"
                            Routine.delete_routines_along_with_pet(pet)
                            pet.destroy
                            user.reload
                            false
                        end
                end
        when "0"
            puts "\nGOODBYE! HAVE A PRODUCTIVE DAY!\n"
            exit
        else 
            print "\n#{input} INVALID OPTION. PLEASE REVIEW THE MENU OPTIONS."
        end
    end
        
    def routine_menu
        puts "Enter [1] to ADD ROUTINE!"
        puts "Enter [2] to VIEW INCOMPLETE ROUTINE FOR THE DAY!"
        puts "Enter [3] to VIEW ALL ROUTINE!"
        puts "Enter [0] to GO BACK TO LAST MENU!"
    end
        
    def routine_user_input(user, pet, input)
        array = user.all_routines_by_name(pet)
        case input
        when "1"
            pet.add_routine(user)
        when "2"
            if array == []
                puts "#{pet.name} doesn't seem to have any incomplete routine yet."
                sleep(2)
                false
            else
                puts "\nPlease select a routine by number:"
                display_array_with_number(user.todo_routines_by_name(pet))
                user.reload
                2
            end
        when "3"
            if array == []
                puts "#{pet.name} doesn't seem to have any routine yet."
                sleep(2)
                false
            else
                puts "\nPlease select a routine by number:"
                display_array_with_number(user.all_routines_by_name(pet))
                3
            end
        when "0"
            $in_pet_menu = false
        else 
            print "****#{input} INVALID OPTION. PLEASE REVIEW THE MENU OPTIONS. \n\n****"
            routine_menu
        end
    end

    def routine_sub_menu(routine)
        puts "Enter [1] to COMPLETE ROUTINE."
        puts "Enter [2] to EDIT/DELETE ROUTINE."
        input = gets.chomp
        case input
            when "1"
                if routine.if_complete == true
                    puts "This routine was already done today."
                    sleep(2)
                    false
                else
                    puts "\nRoutine: #{routine.name}\n#{routine.description}\n\nIs this routine finished? Y/N"
                    complete = gets.chomp
                    if complete == "Y"
                        routine.if_complete = true
                        routine.on_date = date_today
                        routine.save
                        puts "\nNoice!\n"
                    end
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
    
    
    def pets_selector(user, number)
        pet_name = user.pets_by_name[number-1]
        Pet.find_by(name:pet_name)
    end
    
    #*************************
            #Routine    
    #*************************

    #find the singular routine object by name of the routine and userID petID
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
                if pet.routines.count == 0
                    pet.add_routine(user)
                end
                while $in_pet_menu && pet do
                    puts "\nThis is #{pet.name}'s Routine menu"
                    pet.reset_routines_status(date_today)
                    puts "There's #{user.todo_routines(pet).count} more incomplete routine(s)\n"
                    user.reload
                    routine_menu
                    proceed = routine_user_input(user, pet, gets.chomp)
                    if proceed == 2
                        routine_name = user.todo_routines_by_name(pet)[gets.chop.to_i-1]
                        routine = routine_selector(routine_name, user, pet)
                        routine_sub_menu(routine)
                    elsif proceed == 3
                        routine_name = user.all_routines_by_name(pet)[gets.chop.to_i-1]
                        routine = routine_selector(routine_name, user, pet)
                        routine_sub_menu(routine)
                    end
                end
            end    
        end
    end



#----------------------------------------------------------
#----------------------------------------------------------

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
end
