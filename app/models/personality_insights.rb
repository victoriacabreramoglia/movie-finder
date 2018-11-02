module PersonalityInsights
require 'json'

  def flatten
    report_arr = []
    self.profile["personality"].each do |big5|
      big5["children"].each do |child|
        trait = child["trait_id"]
        score = child["raw_score"]
        report_arr.push({trait_id: trait, raw_score: score})
      end
    end
    report_arr
  end

  def euclidean_distance obj1, obj2
    sum = 0.0
    obj1_flattened = obj1.flatten
    obj2_flattened = obj2.flatten
    obj1_flattened.each_index do |x|
      diff = (obj1_flattened[x][:raw_score] - obj2_flattened[x][:raw_score])
      if diff != 0.0
        diff = diff.abs**2
      end
      sum += diff
    end
    if sum != 0.0
      1 - ((sum/obj1_flattened.count)**0.5)
    else
      0
    end
  end

  def generate_matches
    match_arr = []
    Critic.all.each do |target|
      diff = euclidean_distance target, self
      match_arr.push({critic: target.id, distance: diff})
    end
    match_arr.each do |match|
      critic = Critic.find_by_id(match[:critic])
      byebug
    end
  end

end