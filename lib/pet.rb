class Pet < ActiveRecord::Base
    has_many :routines
    has_many :users, through: :routines

    def self.data_saver
        bye = Pet.all.select{|pet| pet.routines == []}
        bye.each{|pet| pet.destroy}
    end

    def add_routine(user)
        puts Rainbow("Please add a routine: ").orange 
        r_name = gets.chomp
        puts Rainbow("Please enter routine #{r_name} description: ").orange
        r_description = gets.chomp
        Routine.create(name:r_name, description: r_description, user_id: user.id, pet_id: self.id)
        puts Rainbow("\n**** #{self.name}'s #{r_name} routine created! ****").yellow
    end

    def reset_routines_status(date)
        arr = self.routines.select{|routine| routine.on_date != date}
        arr.each{|routine| routine.if_complete = nil}
        arr.each{|routine| routine.save}
    end
    
end