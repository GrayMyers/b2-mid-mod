class Actor < ApplicationRecord
  has_many :actor_movies
  has_many :movies, through: :actor_movies

  def associates
    #not currently working and not clean code, was running out of time and wanted to get it working
    assoc = movies.collect { |movie| movie.actors }.uniq[0]{ |actor| actor.id}
  end
end
