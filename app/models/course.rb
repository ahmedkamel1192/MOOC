class Course < ApplicationRecord
    validates :title, presence: true,uniqueness: true
    has_many :lectures 
end
