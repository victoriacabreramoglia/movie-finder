class DashboardController < ApplicationController

  def home
    @data = {
    labels: ["Openness", "Conscientiousness", "Extraversion", "Agreeableness", "Emotional Range"],
    datasets: [
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

  def movies
    @matches = current_user.matches
  end

  def critics
    @matches = current_user.matches
  end

end
