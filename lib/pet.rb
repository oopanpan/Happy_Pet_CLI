class Pet < ActiveRecord::Base
    has_many :routines
    has_many :users, through: :routines

    def self.data_saver
        bye = Pet.all.select{|pet| pet.routines == []}
        bye.each{|pet| pet.destroy}
    end

    def add_routine(user)
        puts "Please add a routine: "
        r_name = STDIN.gets.chomp()
        puts "Please enter routine #{r_name} description: "
        r_description = STDIN.gets.chomp()
        Routine.create(name:r_name, description: r_description, user_id: user.id, pet_id: self.id)
        puts "\n****#{self.name}'s #{r_name} routine created!***"
    end

    def reset_routines_status(date)
        arr = self.routines.select{|routine| routine.on_date != date}
        arr.each{|routine| routine.if_complete = nil}
        arr.each{|routine| routine.save}
    end

end