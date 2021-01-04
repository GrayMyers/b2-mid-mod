class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
  end

  def update
    movie = Movie.find(params[:id])
    actor = Actor.where(name: params[:name])[0]
    ActorMovie.create(movie: movie, actor: actor)

    redirect_to("/movies/#{movie.id}")
  end
end
