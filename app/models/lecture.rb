class Lecture < ApplicationRecord
    acts_as_commentable
    acts_as_votable

    belongs_to :course

end