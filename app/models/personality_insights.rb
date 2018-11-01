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

end