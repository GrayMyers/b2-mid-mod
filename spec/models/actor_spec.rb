require "rails_helper"
describe Actor, type: :model do
  describe "relationships" do
    it {should have_many :movies}
    it {should have_many :actor_movies}
  end

  describe "instance methods" do

    before :each do
      @studio1 = Studio.create(name: "studio 1", location: "here")

      @studio2 = Studio.create(name: "studio 2", location: "there")

      @movie1 = @studio1.movies.create(title: "movie 1", year: "1924", genre: "old movies")
      @movie2 = @studio1.movies.create(title: "movie 2", year: "2020", genre: "horror")
      @movie3 = @studio2.movies.create(title: "movie 3", year: "1880", genre: "not a movie")

      @actor1 = Actor.create(name: "actor 1", age: "2")
      @actor2 = Actor.create(name: "actor 2", age: "48")
      @actor3 = Actor.create(name: "actor 3", age: "28")
      @actor4 = Actor.create(name: "actor 4", age: "3")
      @actor5 = Actor.create(name: "actor 5", age: "80")

      ActorMovie.create(movie: @movie1, actor: @actor1)
      ActorMovie.create(movie: @movie1, actor: @actor2)

      ActorMovie.create(movie: @movie2, actor: @actor2)
      ActorMovie.create(movie: @movie2, actor: @actor3)
      ActorMovie.create(movie: @movie2, actor: @actor4)
      ActorMovie.create(movie: @movie2, actor: @actor5)

      ActorMovie.create(movie: @movie3, actor: @actor1)
      ActorMovie.create(movie: @movie3, actor: @actor3)
    end

    it "associates" do
      expect(@actor1.associates).to eq([@actor2, @actor3])
      expect(@actor2.associates).to eq([@actor1, @actor3, @actor4, @actor5])
      expect(@actor3.associates).to eq([@actor1, @actor2, @actor4, @actor5])
    end
  end
end
