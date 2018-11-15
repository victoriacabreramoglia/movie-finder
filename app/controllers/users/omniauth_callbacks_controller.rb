class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    # AT SOME POINT, MAKE THIS NOT BE A RESOURCE AND API-CALL HOG
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.access_token = request.env["omniauth.auth"]["credentials"]["token"]
    @user.access_token_secret = request.env["omniauth.auth"]["credentials"]["secret"]

    sign_in @user
    if !current_user.initialized?
      @user.initialized = true
      @user.grab_tweets
      @user.generate_profile
      @user.generate_matches
      @user.email = rand.to_s[2..11] + "@gmail.com"
    end

    # Uh oh, conceptual apparatus breaks: we actually only have a Review model, no Movie yet
    @user.save
     redirect_to dashboard_path
  end
end