namespace :reviews do
  desc "TODO"
  task generate_scores: :environment do
    Review.all.each do |review|
      review.num = 0.0
      review.generate_score
    end
  end

end
