class Routine < ActiveRecord::Base
    belongs_to :user
    belongs_to :pet

    def self.delete_routines_along_with_pet(pet)
        bye = Routine.all.select{|routine| routine.pet_id == pet.id}
        bye.each{|routine| routine.destroy}
    end

    def edit_routine_by_prompt
        puts Rainbow("This is the #{self.pet.name}'s #{self.name} routine. Edit?").orange 
        confirmation = true
        while confirmation
            puts "Enter" + Rainbow(" [1] ").cyan + Rainbow("Edit entry").underline
            puts "Enter" + Rainbow(" [2] ").cyan + Rainbow("Delete entry").underline
            choice = gets.chomp
            if choice == "1"
                puts Rainbow("What's the new name of the routine?").orange 
                name = gets.chomp
                puts Rainbow("Describe the new #{name} routine for #{self.pet.name}.").orange 
                des = gets.chomp
                self.name = name
                self.description = des
                self.save
                puts Rainbow("**** ROUTINE ENTRY UPDATED! ****").yellow
                confirmation = false
            elsif choice == "2"
                puts Rainbow("**** Warning, deleting the last routine will erase pet data on your account. ****").magenta
                puts Rainbow("Deleting '#{self.name}' for #{self.pet.name}. Confirm? Y/N").orange 
                del_confirm = gets.chomp
                if del_confirm == 'Y'
                    puts Rainbow("**** ROUTINE ENTRY DELETED! ****").yellow
                    self.destroy
                    confirmation = false
                    $in_pet_menu = false
                end
            else
                puts Rainbow("**** INVALID OPTION. PLEASE REVIEW THE MENU OPTIONS. ****").magenta
                sleep(2)
            end
        end
    end
end