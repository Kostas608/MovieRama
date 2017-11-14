class Movie < ActiveRecord::Base
	belongs_to :user
	has_many :likes
	acts_as_votable

end
