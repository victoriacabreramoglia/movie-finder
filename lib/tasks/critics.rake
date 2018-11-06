require 'nokogiri'
require 'open-uri'
require 'byebug'

namespace :critics do
  desc "TODO"
  task scrub_ebert: :environment do
    Critic.all.each do |critic|
      if (critic.reviews.count == 0)
        critic.destroy!
      end
    end
  end

  task generate_profiles: :environment do
    Critic.all.each do |critic|
      critic.generate_profile
    end
  end

  task import_ebert: :environment do
    # Variable storage--put stuff here
    page = Nokogiri::HTML(open('https://www.rogerebert.com/contributors'))
    critic_links = []
    review_links = []
    review_bodies = []
    critics_arr = []

    # Populate the critics_arr with urls for each contributor
    critics_list = page.xpath('//figcaption/h4/a/@href')
    base_url = 'https://www.rogerebert.com'
    critics_list.each do |critic|
      critic_url = base_url + critic.text
      critic_page = Nokogiri::HTML(open(critic_url))
      critics_arr.push(
        {name:'',
        page_link: critic_url,
        bio: critic_page.xpath('//section[@class="about"]').text,
        name: critic_page.xpath('//figcaption/h1').text,
        reviews: []}
        )
    end
    # Visit each page, grab contributor name and last X reviews
    # Doesn't yet filter for non-critic contributors
    critics_arr.each do |critic|
      critic_page = Nokogiri::HTML(open(critic[:page_link]))
      critic[:name] = critic_page.xpath('//h1').text
      review_objs = critic_page.xpath('//h5/a/@href')
      review_links = []
      review_objs.each do |object|
        review_links.push object.text
      end
      critic[:reviews] = review_links
    end
    critics_arr.each do |critic|
      critic_created = Critic.create ({
        name: critic[:name],
        bio: critic[:bio],
        critic_page: critic[:page_link],
        origin: 'ebert'
      })
      critic[:reviews].each do |review|
        review_url = "https://www.rogerebert.com" + review
        review_page = Nokogiri::HTML(open(review_url))
        review_created = Review.create ({
          url: review,
          movie_title: review_page.xpath("//h1[@itemprop='name']").text,
          dec: 4,
          num: 0
        })
        critic_created.reviews << review_created
      end
    end
  end
end
