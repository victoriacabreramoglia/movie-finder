class AddMovieObjectToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :movie, :json
  end
end
