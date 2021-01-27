class CommandLineInterface

    #*************************
            #INTERFACE
    #*************************
    #get user input, return the imput content
    def user_name_input
        gets.chomp.capitalize
    end
    #display greeting message
    def display_greeting_message
        puts "Welcome to This App"
        puts "Please enter your name:"
    end

    def top_menu
        puts "What would you like to do?"
        puts "[1] Add a new pet"
        puts "[2] View all of your pet(s)"
        puts "[3] "
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

    #*************************
            #Routine    
    #*************************
    def add_routine_by_prompt(user, pet)
        puts "\n\nCongratulations on your new pet"
        puts "What's the name of the routine"
        name = gets.chomp.capitalize
        puts "Description of the routine"
        description = gets
        Routine.create(name: name, description: description, user_id: user.id, pet_id: pet.id )
    end

    




    # def run
    #     display_all_pets_by_name
    #     display_greeting_message
    #     user = User.find_or_create_by(name: user_name_input)
    #     puts "Welcome, #{user.name}"
    #     top_menu
    #     gets


    # end







    def run 
        user = greet 
        self.menu_option(user)
        puts "Hi"
    end

    def greet 
        puts "\n\nWelcome to PanSin Pet Routine Checker"
        puts "Please enter your name: "
        input = STDIN.gets.chomp()
        user = User.find_or_create_by(name:input)
    end

    def menu_option(user)
        puts "\n\nPress 1 to ADD PETS!"
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
        puts "Please enter #{input} species: "
        new_pet.species = STDIN.gets.chomp()
        puts "Please enter #{input} age: "
        new_pet.age = STDIN.gets.chomp()
        new_pet.save
        puts "Pet #{input} created!"
        add_routine(user)
    end

    #add a new routine for the pet
    def add_routine(user)
        puts "\n\nTo add a routine, Please enter pet name: "
        input1 = STDIN.gets.chomp()
        puts "Please enter routine: "
        input2 = STDIN.gets.chomp()
        nr = Pet.find_by(name:input1)
        new_routine = Routine.new(user_id:user.id, pet_id:nr.id, name:input2)
        puts "Please enter #{input2} description: "
        new_routine.description = STDIN.gets.chomp()
        new_routine.save
        puts "Pet #{input1} #{input2} routine created!"
        routine_menu_option(user)
    end

    def view_current_routine(user)
        #Routine.find_by(user_id:user.id, pet_id:pet.id)
        #select the pet , then allow to select the routines
        #puts "\n\nPlease select from the following pets: "
        puts "\n\nPlease enter pet name: "
        input1 = STDIN.gets.chomp()
        puts "\n\nPlease select from the following current routines: "
        Routine.all.each do |routine| 
            if pet.name == input1
                puts routine.name
            end
        end #should we use .uniq#


        puts "\n\nPlease select the routine: "
        input = STDIN.gets.chomp()
        Routine.find_by(name:input).pets.each do |pet|
            puts "\n\n#{pet.name} Routine"
            puts "Routine name: #{routine.name}"
            puts "Routine description: #{routine.description}"
        end
        routine_menu_option(user)
    end

    def delete_routine(user)
        user.routines.each do |r|
            puts "Routine ID#: #{r.id}"
            puts "Routine name: #{r.name}"
            puts "Routine description: #{r.description}"
        end
        puts "\n\nPlease select the routine to delete by Routine ID#: "
        input = STDIN.gets.chomp()
        if user.routines.ids.include?(input)
            Routine.find(input.to_i).destroy
            # Routine.find(input).destroy
            puts "\n\nRoutine ID##{input} deleted!"
        else 
            puts "\n\nYOU HAVE NO RIGHTS TO THIS ROUTINE!"
        end
        routine_menu_option(user)
    end

    def routine_menu_option(user)
        puts "\n\nPress 1 to ADD ROUTINE!"
        puts "Press 2 to VIEW ALL ROUTINE!"
        puts "Press 3 to DELETE ROUTINE!"
        puts "Press 0 to EXIT! "
        input = STDIN.gets.chomp()
        puts self.routine_user_input(user, input)
    end

    def routine_user_input(user, input)
        case input
        when "1"
            add_routine(user)  
        when "2"
            view_current_routine(user)
        when "3"
            delete_routine(user)
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
