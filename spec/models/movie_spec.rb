require "rails_helper"
describe Movie, type: :model do
  describe "relationships" do
    it {should belong_to :studio}
    it {should have_many :actors}
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

      ActorMovie.create(movie: @movie1, actor: @actor1)
      ActorMovie.create(movie: @movie1, actor: @actor2)

      ActorMovie.create(movie: @movie2, actor: @actor2)
      ActorMovie.create(movie: @movie2, actor: @actor3)

      ActorMovie.create(movie: @movie3, actor: @actor1)
      ActorMovie.create(movie: @movie3, actor: @actor3)
    end

    it "average_age" do
      expect(@movie1.average_age).to eq(25)
      expect(@movie2.average_age).to eq(38)
      expect(@movie3.average_age).to eq(15)
    end

    it "actors_by_age" do
      expect(@movie1.actors_by_age).to eq([@actor1, @actor2])
      expect(@movie2.actors_by_age).to eq([@actor3, @actor2])
      expect(@movie3.actors_by_age).to eq([@actor1, @actor3])
    end
  end
end
