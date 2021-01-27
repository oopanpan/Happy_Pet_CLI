User.destroy_all
Pet.destroy_all
Routine.destroy_all

10.times do
    User.create(name:Faker::Name.name)
end

5.times do
    Pet.create(name:Faker::Name.first_name, age:Faker::Number.within(range: 1..10), species: "dog")
end

5.times do
    Pet.create(name:Faker::Name.first_name, age:Faker::Number.within(range: 1..10), species: "cat")
end