class CommandLineInterface

    def run 
        user = greet 
        self.menu_option(user)
    end

    def greet 
        puts "Welcome to Pan Sin"
        input = STDIN.gets.chomp()
        user = User.find_or_create_by(name:input)
    end

    
end