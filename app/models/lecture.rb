class Lecture < ApplicationRecord
    validates :content, presence: true,uniqueness: true
    validates :attachment, presence: true,uniqueness: true
    

    acts_as_commentable
    acts_as_votable

    belongs_to :course

end