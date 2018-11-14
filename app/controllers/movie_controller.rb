class MovieController < ApplicationController
  include Clients
  def show
    @review = Review.find(params[:review_id])
    @review_url = "https://www.rogerebert.com" + @review.url
    @imdb_url = "https://www.imdb.com/title/" + @review.movie["imdbID"]
    @data = {
        labels: ["Openness", "Conscientiousness", "Extraversion", "Agreeableness", "Emotional Range"],
        datasets: [{
          label: "Current Critic",
        backgroundColor: "rgba(0, 0, 255, 0.4)",
          data: [
            @review.critic.profile["personality"][0]["raw_score"].to_d,
            @review.critic.profile["personality"][1]["raw_score"].to_d,
            @review.critic.profile["personality"][2]["raw_score"].to_d,
            @review.critic.profile["personality"][3]["raw_score"].to_d,
            @review.critic.profile["personality"][4]["raw_score"].to_d
          ]},
          { label: "Current User",
            backgroundColor: "rgba(255, 0, 0, 0.4)",
            data: [
            current_user.profile["personality"][0]["raw_score"].to_d,
            current_user.profile["personality"][1]["raw_score"].to_d,
            current_user.profile["personality"][2]["raw_score"].to_d,
            current_user.profile["personality"][3]["raw_score"].to_d,
            current_user.profile["personality"][4]["raw_score"].to_d
          ]}]
    }
  end

  def index
    @reviews = Review.order(:movie_title).page params[:page]
  end
end
