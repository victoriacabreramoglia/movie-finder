class Review < ApplicationRecord
  belongs_to :critic

  require 'open-uri'

  def generate_score
    if self.critic.origin === 'ebert'
      s = self
      page = Nokogiri::HTML(open('https://www.rogerebert.com' + self.url))
      s.num += page.xpath('//p[@class="byline"]//i[@class="icon-star-full"]').count
      s.num += (page.xpath('//p[@class="byline"]//i[@class="icon-star-half"]').count.to_d/2)
      s.save
    end
  end

end
