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

    def pets_selector(user, number)
        pet_name = user.pets_by_name[number-1]
        Pet.find_by(name:pet_name)
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

    




    def run
        running = true
        while running do
            display_greeting_message
            user = User.find_or_create_by(name: user_name_input)
            puts "Welcome, #{user.name}"
            top_menu
            pet = top_menu_selection(user, gets.chomp)

            routine_menu_option
            routine_user_input(user, pet, gets.chomp)

        gets
        end


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

    def top_menu_selection(user, input)
        case input
        when "1"
            pet = user.add_pet_by_prompt
            puts "#{pet.name} is a lovely cutie."
            pet
        when "2"
            display_array_with_number(user.pets_by_name)
            pet = pets_selector(user, gets.chomp.to_i)
            pet
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
    def add_routine(user, pet)
        # puts "\n\nPlease enter pet name: "
        # input1 = STDIN.gets.chomp()
        puts "Please add a routine: "
        r_name = STDIN.gets.chomp()
        # nr = Pet.find_by(name:input1)
        # new_routine = Routine.new(user_id:user.id, pet_id:nr.id, name:input2)
        puts "Please enter routine #{r_name} description: "
        r_description = STDIN.gets.chomp()
        Routine.create(name:r_name, description: r_description, user_id: user.id, pet_id: pet.id)
        puts "Pet #{pet.name}, #{r_name} routine created!"
        routine_menu_option
    end

    def view_current_routine(user, pet)
        #Routine.find_by(user_id:user.id, pet_id:pet.id)
        puts "\n\nPlease select from the following current routines:"
        Routine.all.each do |routine| 
            puts routine.name
        end
    end


    def routine_menu_option
        puts "Press 1 to ADD ROUTINE!"
        puts "Press 2 to VIEW ALL ROUTINE!"
        puts "Press 0 to exit! "
    end

    def routine_user_input(user, pet, input)
        case input
        when "1"
            add_routine(user, pet)
        when "2"
            display_array_with_number(user.all_routines_by_name(pet))
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
