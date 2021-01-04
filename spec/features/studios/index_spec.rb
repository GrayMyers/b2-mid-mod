require "rails_helper"

describe "studio index page" do
  before :each do
    @studio1 = Studio.create(name: "studio 1", location: "here")

    @studio2 = Studio.create(name: "studio 2", location: "there")

    @movie1 = @studio1.movies.create(title: "movie 1", year: "1924", genre: "old movies")
    @movie2 = @studio1.movies.create(title: "movie 2", year: "2020", genre: "horror")
    @movie3 = @studio2.movies.create(title: "movie 3", year: "1880", genre: "not a movie")

    @actor1 = Actor.create(name: "actor 1", age: "2")
    @actor2 = Actor.create(name: "actor 2", age: "47")
    @actor3 = Actor.create(name: "actor 3", age: "28")

    ActorMovie.create(movie: @movie1, actor: @actor1)
    ActorMovie.create(movie: @movie1, actor: @actor2)

    ActorMovie.create(movie: @movie2, actor: @actor2)
    ActorMovie.create(movie: @movie2, actor: @actor3)

    ActorMovie.create(movie: @movie3, actor: @actor1)
    ActorMovie.create(movie: @movie3, actor: @actor3)
  end

  it "shows all studios and has their associated movies under those studios" do
    visit "/studios/"
    expect(page).to have_content("studio 1")
    expect(page).to have_content("studio 2")
    
    within(page.find("#s-#{@studio1.id}")) do
      expect(page).to have_content("movie 1")
      expect(page).to have_content("movie 2")
    end

    within(page.find("#s-#{@studio2.id}")) do
      expect(page).to have_content("movie 3")
    end
  end
end
