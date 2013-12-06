class Question < ActiveRecord::Base
  belongs_to :test
  has_many :answers

  def grid_in?
    !["A","B","C","D","E"].include?(correct_answer)
  end


  private
    def question_params
      params.require(:question).permit(:segment, :section, :question_num,
                                      :category, :difficulty, :correct_answer)
    end

end
