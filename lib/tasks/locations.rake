require 'nokogiri'
require 'open-uri'
require 'byebug'

namespace :locations do
  desc "TODO"
  task import: :environment do
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
      critic[:reviews].push review_links.slice(0,7)
    end
    critics_arr.each do |critic|

    end
    byebug
  end
end
