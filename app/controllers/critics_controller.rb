class CriticsController < ApplicationController
  def index
  end

  def show
    @critic = Critic.find(params[:critic_id])
     @data = {
        labels: ["Openness", "Conscientiousness", "Extraversion", "Agreeableness", "Emotional Range"],
        datasets: [{
          label: "Current Critic",
        backgroundColor: "rgba(0, 0, 255, 0.4)",
          data: [
            @critic.profile["personality"][0]["raw_score"].to_d,
            @critic.profile["personality"][1]["raw_score"].to_d,
            @critic.profile["personality"][2]["raw_score"].to_d,
            @critic.profile["personality"][3]["raw_score"].to_d,
            @critic.profile["personality"][4]["raw_score"].to_d
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
end
