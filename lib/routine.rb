class Routine < ActiveRecord::Base
    belongs_to :user
    belongs_to :pet

    def edit_routing_by_prompt
        puts "This is the #{self.pet.name}'s routine. Edit? Y/N"
        confirmation = gets.chomp
        while confirmation == 'Y'
            puts "[1] Edit entry"
            puts "[2] Delete entry"
            choice = gets.chomp
            if choice == "1"
                puts "What's the new name of the routine"
                name = gets.chomp
                puts "Describe the new #{name} routine for #{self.pet.name}"
                des = gets.chomp
                self.name = name
                self.description = des
                self.save
                puts "Routine updated!"
                confirmation = false
            elsif choice == "2"
                puts "Deleteing #{self.name}, for #{self.pet.name}. Confirm? Y/N"
                del_confirm = gets.chomp
                if del_confirm == 'Y'
                    self.destroy
                    puts "Routine entry deleted"
                    confirmation = false
                end
            else
                puts "\nInput not regconize, please choose again."
            end
        end
    end
end