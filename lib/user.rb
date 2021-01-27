class User < ActiveRecord::Base
    has_many :routines    
    has_many :pets, through: :routines 
end