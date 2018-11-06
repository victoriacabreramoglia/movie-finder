class Critic < ApplicationRecord
  has_many :reviews
  has_many :matches
  has_many :users, through: :matches

  require 'open-uri'
  require 'json'
  include Clients
  include PersonalityInsights

  def generate_profile
    File.open('profile.txt', 'w+') do |f|
      f.write grab_reviews
      f.close
    end
    client = watson_client
    psych_profile = client.profile(
      content: File.open('profile.txt'),
      content_type: "text/plain",
      raw_scores: true,
      consumption_preferences: true
    ).result
    File.delete(Dir.getwd + '/profile.txt')
    s = self
    s.profile = psych_profile
    s.save
  end

  def grab_reviews
    review_text = ''
    to_slice = 0
    if self.reviews.count < 5
      to_slice = self.reviews.count
    else
      to_slice = 5
    end
    review_selection = self.reviews.slice(0,to_slice)
    review_selection.each do |review|
      url = 'https://www.rogerebert.com' + review.url
      page = Nokogiri::HTML(open(url))
      page.xpath('//div[@itemprop="reviewBody"]/p').each do |review_graf|
        review_text += review_graf.text
      end
    end
    review_text
  end

end