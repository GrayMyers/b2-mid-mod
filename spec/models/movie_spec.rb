require "rails_helper"
describe Movie, type: :model do
  describe "relationships" do
    it {should belong_to :studio}
    it {should have_many :actors}
    it {should have_many :actor_movies}

  end
end
