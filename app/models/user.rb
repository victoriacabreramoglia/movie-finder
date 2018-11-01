class User < ApplicationRecord
  require 'json'
  include Clients

  has_many :matches
  has_many :critics, through: :matches
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, :omniauth_providers => [:twitter]

   def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
    end
  end

# populate User.timeline with a string of last 400 tweets
  def grab_tweets
    client = twitter_client(self.access_token, self.access_token_secret)
    # Something here is making this array bad to work with.
    # Stores Twitter gem objects before stringification into db table
    tweets_arr = []
    tweets = client.user_timeline(16298441, options = {count:  200})
    tweets_arr.push tweets
    # Twitter Ruby API restricts calls to 200 tweets/per request
    # Tweet IDs are (roughly) chronologically sequential, so...
    # ...grab `id` of last tweet, and, next time, grab tweets older than that
    1.times do
      last_max_id = tweets_arr[0][-1].id
      tweets = client.user_timeline(16298441, options = {count:  200, max_id: last_max_id})
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

  # Generate pysch profile

  def generate_profile
    client = watson_client
    profile = client.profile(
      content: File.open('app/assets/war-and-peace-1.rtf'),
      content_type: "text/plain",
      raw_scores: true,
      consumption_preferences: true
    ).result
  end

  def puts_pwd
    Dir.getwd
  end

end
