class MovieController < ApplicationController
  include Clients
  def show
    @review = Review.find(params[:review_id])
  end
end
