# Module One Final Project

Name: Happy Pet App (Command Line CRUD App) 

Contributors: Kai Peng Li (GitHub: oopanpan) & 
              Sin Wildy (GitHub: urbanemotions) 

Acknowledgements: Lantz Warrick (Flatiron School - Seattle) & 
                  Jasper Reed (Flatiron School - Seattle)

Goal: ActivityRecord allowing users to:-
  * add pet(s)
  * add routine(s) for each pet
  * view all pets for a particular user
  * view all routines for a particular pet 
  * select and edit the routine(s) for a particular pet 
  * select and complete the routine(s) for a particular pet 
  * select and delete routine(s) for a particular pet

Description: Users have the ability to login and have the option to view and manage their pet(s) and routine(s). 
Users can add new pet(s), view all their pet(s), view their pets routine(s), add new routine(s) for each pet, 
edit/update the routine(s) for each pet, delete routine(s) for each pet, and update the status to completed when 
the routine is completed on a daily basis. 
  * As a user, I want to be able to enter my name to retrieve my pet(s) records
  * As a user, I want to be able to add a new pet(s) and new routine(s) for that particular pet 
  * As a user, I want to be able to retrieve a list of routine(s) for each pet 
  * As a user, I want to be able to edit an existing routine(s) for a particular pet
  * As a user, I want to be able to delete an existing routine(s) for a particular pet
  * As a user, I want to be able to select an existing routine(s) and change the status to complete, in order to display the current incomplete routine count

Installation instructions:
* In your terminal:-
  * Clone the repository:- https://github.com/oopanpan/ruby-project-guidelines
  * cd into the directory
  * Type 'bundle install'
  * Type 'rake db:migrate'
  * Type 'rake db:seed'
  * Type 'ruby bin/run.rb', which will load the Happy Pet App

Gems: source - "https://rubygems.org"
* gem 'activerecord', '~> 5.2.3', :require => 'active_record'
* gem 'rake'
* gem 'require_all'
* gem 'sqlite3', '~>1.3.6'
* gem 'pry'
* gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
* gem 'rspec'
* gem 'database_cleaner'
* gem 'faker'
* gem 'rainbow'

Happy Pet App Basic instructions:
* Welcome screen, and prompts the user to enter their name  
* Display the menu: 
  * Enter [1] to ADD A NEW PET!
  * Enter [2] to VIEW ALL OF YOUR PET(S)!
  * Enter [3] to SAY GOODBYE TO A PET!
  * Enter [0] to QUIT!
* To add a new pet
  * Enter 1, prompting the user to enter the name of the pet 
  * Enter pet name, prompting the user to enter the species 
  * Enter the species, prompting the user to enter the age 
  * Enter the age to display a message related to the pet, promopting the user to add a new routine for that pet
* To add a routine 
  * Enter routine name, prompting the user to enter the routine description
  * Enter routine description, display a message related to the pet and routine, and set the routine status as incomplete
* Display the menu:
  * Enter [1] to ADD ROUTINE!
  * Enter [2] to VIEW INCOMPLETE ROUTINE FOR THE DAY!
  * Enter [3] to VIEW ALL ROUTINE!
  * Enter [0] to GO BACK TO LAST MENU!  
* To view incomplete routine(s)  
  * Enter 2, allowing the user to view all incomplete routine(s) for a particalar pet
  * Enter a number assigned to the routine to make changes, which will allow the user to select from the following menu:
    * Enter [1] to COMPLETE ROUTINE
    * Enter [2] to EDIT/DELETE ROUTINE
  * Enter 1, prompting the user to confirm whether the routine is completed or not
  * Display the current number of incomplete routine(s) for that particular pet
* To view all routine(s)
  * Enter 3, allowing the user to view all routine(s) for a particular pet 
  * Display all the routines no matter the status (completed and incompleted) 
* To delete routine(s) 
  * Enter 2, allowing the user to edit or delete the routine entry 

For more instructions on how to use Happy Pet App, please subscribe to our subscription. 