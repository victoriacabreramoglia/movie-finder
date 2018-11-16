class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.access_token = request.env["omniauth.auth"]["credentials"]["token"]
    @user.access_token_secret = request.env["omniauth.auth"]["credentials"]["secret"]

    sign_in @user
    if !current_user.initialized?
      @user.initialized = true
      @user.grab_tweets
      if @user.timeline.split(" ").count > 150
        @user.generate_profile
        @user.generate_matches
        @user.email = rand.to_s[2..11] + "@gmail.com"
        # Uh oh, conceptual apparatus breaks: we actually only have a Review model, no Movie yet
        @user.save
        redirect_to dashboard_path
      else
        @user.destroy!
        redirect_to error_timeline_path
      end
    else
      if @user.timeline.split(" ").count > 150
        redirect_to dashboard_path
      else
      redirect_to error_timeline_path
      end
    end

  end
end