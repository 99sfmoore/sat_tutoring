require 'pry-nav'

class Student < ActiveRecord::Base
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false }
  before_save { self.email = email.downcase }
  belongs_to :site
  belongs_to :tutor
  has_many :answers
  has_many :questions, through: :answers
  has_many :scores
  has_many :hw_answers

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
      self.answers.build(question_id: question.id, answer_choice: answer_hash["answer_choice"])
    end
  end

  def enter_answers(test,param_hash)
    test.questions.each do |q|
      answer = param_hash[q.id.to_s]
      self.answers.build(question_id: q.id, answer_choice: answer)
    end
  end

  def check_homework(hw,param_hash)
      hw.hw_questions.each do |q|
      self.hw_answers.build(hw_question: q, answer_choice: param_hash[q.id.to_s])
    end
  end


  def raw_score(test, segment)
    correct = 0
    incorrect = 0
    omitted = 0
    penalty = 0
    test.questions.where("segment = ?",segment).each do |q|
      student_answer = Answer.where("question_id = ? AND student_id = ?", q, self).first
      unless student_answer.nil?
        student_answer = student_answer.answer_choice
        if q.correct_answer == student_answer
          correct += 1
        elsif student_answer == "-"
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





end
