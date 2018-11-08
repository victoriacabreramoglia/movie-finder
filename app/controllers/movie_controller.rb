class MovieController < ApplicationController
  def show
    @review = Review.find(params[:review_id])
  end
end
