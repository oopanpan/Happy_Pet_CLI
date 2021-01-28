class Routine < ActiveRecord::Base
    belongs_to :user
    belongs_to :pet

    def self.delete_routines_with_no_pet
        bye = Routine.all.select{|routine| routine.pet === []}
        bye.each{|routine| routine.destroy}
    end

    def edit_routine_by_prompt
        puts "This is the #{self.pet.name}'s #{self.name} routine. Edit?"
        confirmation = true
        while confirmation
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
                    puts "***ROUTINE ENTRY DELETED***"
                    confirmation = false
                end
            else
                puts "\nInput not regconize, please choose again."
            end
        end
    end
end