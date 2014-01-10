

class Test < ActiveRecord::Base
  has_many :sections, dependent: :destroy
  has_many :questions, through: :sections
  has_many :scores

  def load_questions_from_file(filename)
    sections = []
    CSV.foreach(filename.path, headers: true) do |row|
      question_hash = row.to_hash
      current_section = self.sections.find_or_initialize_by(section_num: question_hash["section"], segment: question_hash["segment"])
      current_section.questions.build(question_hash.except("section", "segment"))
      current_section.save
    end
    self.save
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
      score_conversion[hash["raw"]] = {math: hash["math"], reading: hash["reading"], writing: hash["writing_mc"]}
    end
    self.conversion = score_conversion.to_json 
  end    

  def scaled_score(raw_score, segment = nil)
    score_conversion = ActiveSupport::JSON.decode(self.conversion)
    scores = score_conversion[raw_score.round.to_s]
    return 200 if raw_score < 6
    if segment == "Math"
      return scores["math"].to_i
    elsif segment == "CR"
      return scores["reading"].to_i
    elsif segment == "Writing"
      return scores["writing_mc"].to_i
    else
      return scores
    end
  end

  def segment_questions(segment)
    questions.where("segment_id = ?",segment)
  end

  # def topics(segment)
  #   if segment = "Math"
  #     topic_hash = math_questions.group_by {|q| q.topic }
  #   elsif segment = "CR"
  #     topic_hash = reading_questions.group_by {|q| q.topic }
  #   elsif segment = "Writing"
  #     topic_hash = writing_questions.group_by {|q| q.topic }
  #   else
  #     #error
  #   end
  #   topic_hash.sort_by {|k,v| k}
  # end

  def performance(student, segment)
    performance_hash = {}
    topic_list = segment_questions(segment).group_by {|q| q.topic}
    topic_list.each do |t, topic_qs|
      performance_hash[t.number] = {}
      category_list = topic_qs.group_by {|q| q.category}
      category_list.each do |c, q_list|
        count = q_list.count
        correct = q_list.count{|q| student.correct?(q)}
        omitted = q_list.count{|q| student.omitted?(q)}
        incorrect = q_list.count{|q| student.incorrect?(q)}
        performance_hash[t.number][c.name] = {count: count,
                                  correct: (correct.to_f/count*100).round,
                                  omitted: (omitted.to_f/count*100).round,
                                  incorrect: (incorrect.to_f/count*100).round}

      end
    end
    performance_hash.sort_by {|k,v| k}
  end


end
