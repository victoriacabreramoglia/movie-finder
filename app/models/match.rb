class Match < ApplicationRecord
  belongs_to :critic
  belongs_to :user

  def recommend_movies
    self.critic.reviews.where("favorite = true")
  end
end

