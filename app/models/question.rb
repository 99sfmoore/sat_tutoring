class Question < ActiveRecord::Base
  belongs_to :section
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :hw_hints
  delegate :section_num, :segment, to: :section
  delegate :topic, to: :category
  validates :section, presence: true


  def grid_in?
    !["A","B","C","D","E"].include?(correct_answer)
  end

  def student_answer(student)
    a = self.answers.where(student: student).first
    a ? a.answer_choice : ""
  end

  def correct?(student)
    if grid_in?
      student_answer(student).to_f == self.correct_answer.to_f
    else
      student_answer(student).upcase == self.correct_answer.upcase
    end
  end

  def omitted?(student)
    student_answer(student).nil? || student_answer(student) == "-" || student_answer(student) == ""
  end

  def incorrect?(student)
    !correct?(student) && !omitted?(student)
  end

  def second_try(student)
    answers.find_by(student: student).second_try
  end

  def second_correct?(student)
    second_try(student) == correct_answer
  end 

  def set_difficulty
    if difficulty_num && difficulty_num >= 1 && difficulty_num <= 5
      case difficulty_num
      when 1 
        self.difficulty = "Low"
      when 2 
        self.difficulty = "Low-Medium"
      when 3 
        self.difficulty = "Medium"
      when 4 
        self.difficulty = "Medium-High"
      when 5 
        self.difficulty = "High"
      end
    elsif difficulty.length > 1
      case difficulty
      when "Low" 
        self.difficulty_num = 1
      when "Medium" 
        self.difficulty_num = 3
      when "High" 
        self.difficulty_num = 5
      end
    end
    self.save
  end

  private
    def question_params
      params.require(:question).permit(:question_num,
                                      :category, :difficulty, :correct_answer, :difficulty_num)
    end

end
