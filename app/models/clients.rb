module Clients

  def watson_client
    IBMWatson::PersonalityInsightsV3.new(
      username: SquidMovie::Application.credentials.IBM[:username],
      password: SquidMovie::Application.credentials.IBM[:password],
      version: "2017-10-13"
    )
  end

  def twitter_client(access_token, access_token_secret)
    Twitter::REST::Client.new do |config|
      config.consumer_key        = SquidMovie::Application.credentials.twitter[:public_key]
      config.consumer_secret     = SquidMovie::Application.credentials.twitter[:secret_key]
      config.access_token        = access_token
      config.access_token_secret = access_token_secret
    end
  end
end