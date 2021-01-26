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
        puts "Press 1 to "
        puts "Press 2 to "
        puts "Press 3 to "
        puts "Press 4 to "
        puts "Press 5 to "
        input = STDIN.gets.chomp()
        puts self.user_input(user, input)
    end

    def user_input(user, input)
        case input
        when "1"
            METHOD NAME 
        when "2"
            METHOD NAME 
        when "3"
            METHOD NAME 
        when "4" 
            METHOD NAME 
        when "5"
            METHOD NAME 
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
    


end