class Student < ActiveRecord::Base
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false }
  before_save { self.email = email.downcase }
  belongs_to :site
  belongs_to :tutor
  has_many :answers
  has_many :questions, through: :answers
  has_many :scores
  has_many :assignments
  has_many :sections, through: :assignments
  has_many :raw_scores

  has_attached_file :avatar, styles: {
    thumb: '32x32#',
    small: '200x300#',
    medium: '300x450>'
  }

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def load_answers(test, filepath)
    CSV.foreach(filepath, headers: true) do |row|
      answer_hash = row.to_hash
      answer_hash["question_num"] = answer_hash["question_num"].to_i
      answer_hash["section"] = answer_hash["section"].to_i
      question = Question.where("test_id = ? AND section = ? AND question_num = ?", test, answer_hash["section"], answer_hash["question_num"]).first
      question.answers.build(student: self, answer_choice: answer_hash["answer_choice"])
      question.save
    end
  end

  def enter_answers(test,param_hash)
    test.questions.each do |q|
      answer = param_hash[q.id.to_s]
      student_answer = q.answers.find_or_initialize_by(student: self)
      student_answer.update_attributes(answer_choice: answer)
      q.save
    end
    raw = self.raw_scores.find_or_initialize_by(test: test) 
    raw.update_attributes(math: my_raw_score(test, Segment.find_by(name: "Math"))[:score],
                          reading: my_raw_score(test, Segment.find_by(name: "Reading"))[:score],
                          writing: my_raw_score(test, Segment.find_by(name: "Writing"))[:score])
    self.save
  end

  def check_homework(hw,param_hash)
    hw.sections.each do |section|
      section.questions.each do |q|
        a = q.answers.find_or_initialize_by(student: self)
        a.update_attributes(answer_choice: param_hash[q.id.to_s].upcase)
        q.save
      end
    end
    a = self.assignments.build(homework: hw, complete: true)
    a.update_attributes(send_hints: true)
    self.save
  end

  def check_second(hw,param_hash)
    hw.sections.each do |section|
      section.questions.each do |q|
        unless q.correct?(self)
          a = answers.find_by(question: q)
          a.update_attributes(second_try: param_hash[q.id.to_s].upcase)
        end
      end
    end
    assignments.find_by(homework: hw).update_attributes(second_try: "complete")
  end

  def my_raw_score(test, segment)
    correct = 0
    incorrect = 0
    omitted = 0
    penalty = 0
    test.segment_questions(segment).each do |q|
      student_answer = Answer.where("question_id = ? AND student_id = ?", q, self).first
      unless student_answer.nil?
        student_answer = student_answer.answer_choice
        if q.correct_answer == student_answer || (q.grid_in? && q.correct_answer.to_f == student_answer.to_f)
          correct += 1
        elsif student_answer == "-" || student_answer == ""
          omitted +=1
        else
          incorrect +=1
          penalty +=1 unless q.grid_in?
        end 
      end
    end
    raw = correct - penalty/4.0
    {correct: correct, incorrect: incorrect, omitted: omitted, penalty: penalty, score: raw}
  end

  def correct?(question)
    answer = self.answers.find_by(question: question)
    answer && answer.correct?
  end

  def incorrect?(question)
    answer = self.answers.find_by(question: question)
    answer && answer.incorrect?
  end

  def omitted?(question)
    answer = self.answers.find_by(question: question)
    if answer
      return answer.omitted?
    else
      true
    end
  end

  def try_rate(test, segment)
    raw = my_raw_score(test,segment)
    (((raw[:correct] + raw[:incorrect])/(raw[:correct] + raw[:incorrect] + raw[:omitted]).to_f)*100).round
  end


  def hit_rate(test, segment)
    raw = my_raw_score(test,segment)
    ((raw[:correct]/(raw[:correct] + raw[:incorrect]).to_f)*100).round
  end

  def open_homeworks
    result = []
    tutor.homeworks.each do |hw|
      result << hw unless Assignment.where("student_id = ? AND homework_id = ?",self.id, hw.id).first
    end
    result.sort_by{|hw| hw.number}
  end

  def second_try_homeworks
    self.assignments.where("second_try = ?", "pending").map {|a| a.homework}
  end

  def send_hints_homeworks
    self.assignments.select {|a| a.send_hints?}.map {|a| a.homework}
  end

  def past_homeworks
    (tutor.homeworks - open_homeworks).sort_by{|hw| hw.number}
  end

  def took?(test)
    a = answers.find_by(question_id: test.questions.map{|q| q.id})
    a ? true : false
  end


end
