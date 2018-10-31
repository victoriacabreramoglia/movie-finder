class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, :omniauth_providers => [:twitter]

   def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
    end
  end

  def twitter_client(access_token, access_token_secret)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = SquidMovie::Application.credentials.twitter[:public_key]
      config.consumer_secret     = SquidMovie::Application.credentials.twitter[:secret_key]
      config.access_token        = access_token
      config.access_token_secret = access_token_secret
    end
  end

  def grab_tweets
    client = twitter_client(self.access_token, self.access_token_secret)
    # Something here is making this array bad to work with
    tweets_arr = []
    tweets = client.user_timeline('kanyewest', options = {count:  200})
    tweets_arr.push tweets
    1.times do
      last_max_id = tweets_arr[0][-1].id
      tweets = client.user_timeline('kanyewest', options = {count:  200, max_id: last_max_id})
      tweets_arr.push tweets
    end
    tweets_string = ''
    tweets_arr[0].each do |tweet|
      tweets_string += tweet.text
    end
    u = self
    u.timeline = tweets_string
    u.save
  end

  def scrub_tweets tweets_arr

  end
end
