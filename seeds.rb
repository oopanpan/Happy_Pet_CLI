User.destroy_all
Pet.destroy_all
Routine.destroy_all

50.times do
    User.create(name:Faker::Name.name)
end