class CommandLineInterface
    
    #*******************#
    #     INTERFACE     #
    #*******************#

    #get user input, return the input content
    def user_name_input
        gets.chomp.capitalize
    end

    #get today's date in a YYYYMMDD format as integer
    def date_today
        date = Time.now.strftime("%F")
        date.split("-").join.to_i
    end

    #display greeting message
    def display_greeting_message
        puts Rainbow("
        ('-. .-.   ('-.      _ (`-.    _ (`-.                       _ (`-.    ('-.   .-') _    
        ( OO )  /  ( OO ).-. ( (OO  )  ( (OO  )                     ( (OO  ) _(  OO) (  OO) )   
        ,--. ,--.  / . --. /_.`     \ _.`     \  ,--.   ,--.       _.`     \(,------./     '._  
        |  | |  |  | \-.  \(__...--''(__...--''   \  `.'  /       (__...--'' |  .---'|'--...__) 
        |   .|  |.-'-'  |  ||  /  | | |  /  | | .-')     /         |  /  | | |  |    '--.  .--' 
        |       | \| |_.'  ||  |_.' | |  |_.' |(OO  \   /          |  |_.' |(|  '--.    |  |    
        |  .-.  |  |  .-.  ||  .___.' |  .___.' |   /  /\_         |  .___.' |  .--'    |  |    
        |  | |  |  |  | |  ||  |      |  |      `-./  /.__)        |  |      |  `---.   |  |    
        `--' `--'  `--' `--'`--'      `--'        `--'             `--'      `------'   `--'    
       ").magenta
        puts Rainbow("Welcome to Happy Pet").yellow
        puts Rainbow("Please enter your name:").orange
    end
    
    def top_menu
        puts Rainbow("What would you like to do? Please select by number").orange 
        puts "Enter" + Rainbow(" [1] ").cyan + Rainbow("Add a new pet").underline
        puts "Enter" + Rainbow(" [2] ").cyan + Rainbow("View all of your pet(s)").underline
        puts "Enter" + Rainbow(" [3] ").cyan + Rainbow("Say goodbye to a pet").underline
        puts "Enter" + Rainbow(" [0] ").cyan + Rainbow("Quit").underline
    end
        
    def top_menu_selection(user, input)
        case input
        when "1"
            pet = user.add_pet_by_prompt
            puts Rainbow("\n **** #{pet.name} **** is a lovely cutie.\nPlease take good care of them!\n").yellow
            pet
        when "2"
            if user.pets == []
                puts Rainbow("\nInteresting, you don't seem to own any pet.").magenta
                sleep(3)
                false
            else
                puts Rainbow("\nHere is the list of your pet(s), please select by number").orange
                display_array_with_number(user.pets_by_name)
                pet = pets_selector(user, gets.chomp.to_i)
            end
        when "3"
            array = user.pets_by_name
            if array == []
                puts Rainbow("\nInteresting, you don't seem to own any pet.").magenta
                sleep(3)
                false
            else
                puts Rainbow("\nWhich pet would you like to say goodbye? Please Select by number").orange
                display_array_with_number(array)
                pet = pets_selector(user, gets.chomp.to_i)
                puts Rainbow("\nWe're saying goodbye to #{pet.name}, correct? Y/N").orange 
                ans = gets.chomp
                if ans == "Y"
                    puts Rainbow("..").yellow
                    sleep(1)
                    puts Rainbow("...").yellow
                    sleep(1)
                    puts Rainbow("Goodbye #{pet.name} we'll miss you!").yellow
                    Routine.delete_routines_along_with_pet(pet)
                    pet.destroy
                    user.reload
                    false
                end
<<<<<<< HEAD
=======
            end
>>>>>>> master
        when "6"
            database_menu(user)
            false
        when "0"
            puts Rainbow("\nGOODBYE! HAVE A PRODUCTIVE DAY!\n").yellow
            exit
        else 
            print Rainbow("\n#{input} INVALID OPTION. PLEASE REVIEW THE MENU OPTIONS.").magenta
        end
    end

<<<<<<< HEAD
    def database_menu(user)
        puts "\nYou're now in a secret cabin."
        puts "Enter [1] to VIEW ALL PET in DATABASE"
        puts "Enter [2] to VIEW ALL ROUTINES in DATABASE"
        puts "Enter [3] to VIEW ALL USERS"
        puts "Enter [4] to VIEW YOUR USER ID"
        puts "Enter [5] to DELETE YOUR ACCOUNT"
        case input
        when "1"

=======
    def pause_on
        puts "Press any key to continue\r"
        gets
    end

    def database_menu(user)
        loop do
            puts "\nYou're now in a secret cabin."
            puts "Enter [1] to VIEW ALL PET in DATABASE"
            puts "Enter [2] to VIEW ALL ROUTINES in DATABASE"
            puts "Enter [3] to VIEW ALL USERS"
            puts "Enter [4] to VIEW YOUR USER ID"
            puts "Enter [5] to DELETE YOUR ACCOUNT"
            puts "Enter [0] to Go Back"
            input = gets.chomp
            case input
            when "1"
                puts display_all_pets_by_name
                pause_on
            when "2"
                puts display_all_routines_by_name
                pause_on
            when "3"
                puts display_all_users_by_name
                pause_on
            when "4"
                puts "\nYour ID is #{user.id}"
                pause_on
            when "5"
                puts "All the associated routines and pets will be erased from database"
                puts "Deleting #{user.name}, Confirm? Y/N"
                confirmation = gets.chomp
                if confirmation == "Y"
                    user.deleting_routines_with_user
                    Pet.data_saver
                    user.destroy
                    puts "\nUser account deleted, exiting program..."
                    pause_on
                    exit
                end
            when "0"
                break
            end
>>>>>>> master
        end
    end
        
    def routine_menu
        puts "Enter" + Rainbow(" [1] ").cyan + Rainbow("to ADD ROUTINE!").underline
        puts "Enter" + Rainbow(" [2] ").cyan + Rainbow("to VIEW INCOMPLETE ROUTINE FOR THE DAY!").underline
        puts "Enter" + Rainbow(" [3] ").cyan + Rainbow("to VIEW ALL ROUTINE!").underline
        puts "Enter" + Rainbow(" [0] ").cyan + Rainbow("to GO BACK TO LAST MENU!").underline 
    end
        
    def routine_user_input(user, pet, input)
        array = user.all_routines_by_name(pet)
        incomp_arr = user.todo_routines(pet)
        case input
        when "1"
            pet.add_routine(user)
        when "2"
            if array == []
                puts Rainbow("#{pet.name} doesn't seem to have any incomplete routine yet.").magenta
                sleep(2)
                false
            elsif incomp_arr.count == 0
<<<<<<< HEAD
                puts Rainbow("*** THERE'S NO MORE ROUTINE FOR #{pet.name} TODAY! ***")
=======
                puts Rainbow("*** THERE'S NO MORE ROUTINE FOR #{pet.name} TODAY! ***").magenta
>>>>>>> master
                sleep(2)
                false
            else
                puts Rainbow("\nPlease select a routine by number:").orange 
                display_array_with_number(user.todo_routines_by_name(pet))
                user.reload
                2
            end
        when "3"
<<<<<<< HEAD
            if array.count == 0
                puts "#{pet.name} doesn't seem to have any routine yet"
=======
            if array == []
                puts Rainbow("#{pet.name} doesn't seem to have any routine yet.").magenta
>>>>>>> master
                sleep(2)
                false
            else
                puts Rainbow("\nPlease select a routine by number:").orange 
                display_array_with_number(user.all_routines_by_name(pet))
                3
            end
        when "0"
            $in_pet_menu = false
        else 
            print Rainbow("**** #{input} INVALID OPTION. PLEASE REVIEW THE MENU OPTIONS. ****").magenta
            routine_menu
        end
    end

    def routine_sub_menu(routine)
        puts "Enter" + Rainbow(" [1] ").cyan + Rainbow("to COMPLETE ROUTINE").underline
        puts "Enter" + Rainbow(" [2] ").cyan + Rainbow("to EDIT/DELETE ROUTINE").underline
        puts "Enter" + Rainbow(" [0] ").cyan + Rainbow("to PREVIOUS MENU").underline
        input = gets.chomp
        case input
        when "1"
            if routine.if_complete == true
                puts Rainbow("This routine was already done today.").yellow
                sleep(2)
                false
            else
                puts Rainbow("\nRoutine: #{routine.name}\n#{routine.description}\n\nIs this routine finished? Y/N").orange
                complete = gets.chomp
                if complete == "Y"
                    routine.if_complete = true
                    routine.on_date = date_today
                    routine.save
                    puts Rainbow("\nNOICE!\n").yellow
                end
            end
        when "2"
            routine.edit_routine_by_prompt
        when "0"
            $in_routine_menu = false
            false
        else 
            print Rainbow("**** #{input} INVALID OPTION. PLEASE REVIEW THE MENU OPTIONS. ****").magenta
            routine_menu
        end
    end
    

    
    #display main menu, take in an user object, display all the dog
    #in the database
    def display_all_pets_by_name
        Pet.all.map{|pet| pet.name}
    end

    def display_all_routines_by_name
        Routine.all.map{|routine| routine.name}
    end

    def display_all_users_by_name
        User.all.map{|user| user.name}
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
        system "clear"
        $running = true
        while $running do
            display_greeting_message
            user = User.find_or_create_by(name: user_name_input)
            while user do
                system "clear"
                puts Rainbow("\nUser: #{user.name}\n").yellow
                top_menu
                pet = top_menu_selection(user, gets.chomp)
                $in_pet_menu = true
                if pet && pet.routines.count == 0
                    pet.add_routine(user)
                end
                while $in_pet_menu && pet do
                    puts Rainbow("\nThis is #{pet.name}'s Routine menu").yellow
                    pet.reset_routines_status(date_today)
                    puts Rainbow("There's #{user.todo_routines(pet).count} more incomplete routine(s)\n").yellow    
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
end