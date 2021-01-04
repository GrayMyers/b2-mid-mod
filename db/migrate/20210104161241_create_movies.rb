class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :year
      t.string :genre
      t.references :movie, foriegn_key: true
    end
  end
end
