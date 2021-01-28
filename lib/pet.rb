class Pet < ActiveRecord::Base
    has_many :routines
    has_many :users, through: :routines

    def self.data_saver
        bye = Pet.all.select{|pet| pet.users === []}
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
end