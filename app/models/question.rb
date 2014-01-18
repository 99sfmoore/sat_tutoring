TOPICS = {  "Angles"=> 9,
            "Averages" => 3,
            "Complex Figures" => 13,
            "Coordinate Planes" => 8,
            "Data Analysis" => 15,
            "Divisibility" => 2,
            "Equations" => 1,
            "Exponents" => 7,
            "Functions" => 1,
            "Geometric Visualization" => 13,
            "Inequalities" => 7,
            "Linear Graphs" => 8,
            "Logic" => 15,
            "Non-Linear Graphs" => 7,
            "Number Lines" =>7,
            "Number Properties" => 2,
            "Permutations and Combinations" => 15,
            "Polygons" => 9,
            "Probability" => 14,
            "Quadratic Equations" => 8,
            "Ratios" => 3,
            "Sequences" => 14,
            "Solids" => 13,
            "Triangles" => 9}

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
    a ? a.answer_choice : "-"
  end

  def correct?(student)
    student_answer(student).upcase == self.correct_answer.upcase
  end

  private
    def question_params
      params.require(:question).permit(:question_num,
                                      :category, :difficulty, :correct_answer)
    end

end
