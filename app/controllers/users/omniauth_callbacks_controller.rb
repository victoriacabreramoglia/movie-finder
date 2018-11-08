class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.access_token = request.env["omniauth.auth"]["credentials"]["token"]
    @user.access_token_secret = request.env["omniauth.auth"]["credentials"]["secret"]
    @user.grab_tweets
    @user.generate_profile
    @user.generate_matches
    @match = @user.matches.first
    # Uh oh, conceptual apparatus breaks: we actually only have a Review model, no Movie yet
    @review_rec = @match.recommend_movies.first
    @user.save
    byebug
     sign_in_and_redirect @user
  end
end