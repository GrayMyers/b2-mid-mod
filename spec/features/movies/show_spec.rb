require "rails_helper"
describe "movie show page" do
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
    visit "/movies/#{@movie2.id}"
  end

  it "shows all movie attributes" do
    expect(page).to have_content(@movie2.title)
    expect(page).to have_content("Year produced: #{@movie2.year}")
    expect(page).to have_content("Genre: #{@movie2.genre}")
  end

  it "shows all actors ordered by ascending age" do
    actor2 = page.find("#actor-#{@actor2.id}")
    actor3 = page.find("#actor-#{@actor3.id}")
    expect(actor3).to appear_before(actor2)
  end

  it "shows average age of all actors" do
    expect(page).to have_content("Average actor age: #{@movie2.average_age}")
  end
end
