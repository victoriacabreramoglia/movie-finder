class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.access_token = request.env["omniauth.auth"]["credentials"]["token"]
    @user.access_token_secret = request.env["omniauth.auth"]["credentials"]["secret"]
    @user.grab_tweets
    @user.generate_profile
    @user.generate_matches
    @matches = @user.matches.first

    # Uh oh, conceptual apparatus breaks: we actually only have a Review model, no Movie yet
    @review_rec = @matches.recommend_movies.first
    @user.save
     sign_in @user
     redirect_to movie_show_path(review_id: @review_rec.id)
  end
end