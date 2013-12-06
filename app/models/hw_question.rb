class HwQuestion < ActiveRecord::Base
  belongs_to :hw_assignment
  has_many :hw_answers
  has_many :hw_hints

  def student_answer(student)
    HwAnswer.where("hw_question_id = ? AND student_id = ?",self,student).first.answer_choice
  end

  def correct?(student)
    student_answer(student) == self.correct_answer
  end
end
