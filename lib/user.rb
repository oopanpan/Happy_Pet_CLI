class User < ActiveRecord::Base
    has_many :pets   
    has_many :routines, through: :pets
end