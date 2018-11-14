namespace :reviews do

  desc "TODO"
  task generate_scores: :environment do
    Review.all.each do |review|
      review.num = 0.0
      review.generate_score
    end
  end

  task scrub_no_plot: :environment do
    count = 0
    Review.all.each do |r|
      if r.movie["Plot"] === "N/A"
        r.destroy!
      end
    end
  end

  task grab_movies: :environment do
    Review.all.each do |r|
      client = r.omdb_client
      scrubbed_title = r.movie_title.scan(/\w+/).join(" ")
      r.movie = client.find_by_title(scrubbed_title)
      if r.movie["Response"] == "False"
        scrubbed_title.sub! "and", " "
        scrubbed_title.sub! "And", " "
        r.movie = client.find_by_title(scrubbed_title)
      end
      r.save
    end
  end

  task long_reviews: :environment do
    Review.all.each do |r|
      client = r.omdb_client
      m = client.find_by_id(r.movie["imdbID"], plot: "full")
      r.movie["Plot"] = m["Plot"]
      r.save
    end
  end

end
