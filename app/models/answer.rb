class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :student
  validates :question, uniqueness: {scope: :student_id}, presence: true
  validates :student, presence: true

  def correct?
    answer_choice == question.correct_answer
  end

  def incorrect?
    answer_choice != question.correct_answer && !omitted? 
  end


  def omitted?
    answer_choice.nil? || answer_choice == "" 
  end
end
