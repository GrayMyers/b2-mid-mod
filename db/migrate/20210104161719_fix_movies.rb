class FixMovies < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :movie_id
    add_column :movies, :studio_id, :bigint
    add_foreign_key :movies, :studios
  end
end
