class Answer < ActiveRecord::Base
  belongs_to :question, dependent: :destroy
  belongs_to :student, dependent: :destroy
  validates :question, uniqueness: {scope: :student_id}, presence: true

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
