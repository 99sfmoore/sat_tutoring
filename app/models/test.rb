require 'pry-nav'

class Test < ActiveRecord::Base
  has_many :questions
  has_many :scores

  def load_questions_from_file(filename)
    CSV.foreach(filename.path, headers: true) do |row|
      self.questions.build(row.to_hash)
    end
  end

  def enter_site_scores(site,param_hash)
    site.students.each do |student|
      s_id = student.id.to_s
      if param_hash[s_id]
        math = param_hash[s_id]["Math"].to_i
        reading = param_hash[s_id]["Reading"].to_i
        writing = param_hash[s_id]["Writing"].to_i
        self.scores.build(student_id: student.id, math: math, reading: reading, writing: writing)
      end
    end
    self.save
  end


  def set_conversion(filename)
    score_conversion = {}
    CSV.foreach(filename.path, headers: true) do |row|
      hash = row.to_hash
      score_conversion[hash["raw"]] = {math: hash["math"], reading: hash["reading"]}
    end
    self.conversion = score_conversion.to_json 
  end    

  def scaled_score(raw_score, segment = nil)
    score_conversion = ActiveSupport::JSON.decode(self.conversion)
    scores = score_conversion[raw_score.round.to_s]
    if segment == "Math"
      return scores["math"].to_i
    elsif segment == "CR"
      return scores["reading"].to_i
    elsif segment == "Writing"
      return 0
    else
      return scores
    end
  end


end
