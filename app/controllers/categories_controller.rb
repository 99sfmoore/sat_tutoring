class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @test = Test.find(params[:test_id])
    @student = Student.find(params[:student_id])
    @questions = @test.questions.where(category: @category).order(:difficulty_num, :section_id, :question_num)
  end
end
