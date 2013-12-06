class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to @student
    else
      render 'new'
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(student_params)
      redirect_to @student
    else
      render 'edit'
    end
  end

  def show
    @student = Student.find(params[:id])
    @tests = Test.all
  end

  def enter_answers #this is not working
    @student = Student.find(params[:id])
    @test = Test.find(params[:test])
  end

  def entered_answers
    @student = Student.find(params[:id])
    test = Test.find(params[:test])
    @student.enter_answers(test, params)
    @student.save
    render 'test_score'
  end

  def check_homework
    @student = Student.find(params[:id])
    @hw = HwAssignment.find(params[:hw])
  end

  def checked_homework
    @student = Student.find(params[:id])
    @hw = HwAssignment.find(params[:hw])
    @student.check_homework(@hw,params)
    @student.save
    render 'shared/homework_result'
  end


  def load_answers
    @student = Student.find(params[:id])
    test = Test.find(params[:test])
    @student.load_answers(test,params[:file].path)
    @student.save
    render 'show'
  end

  def test_score
    @student = Student.find(params[:id])
    @test = Test.find(params[:test])
    render 'test_score'
  end

  private

    def student_params
      params.require(:student).permit(:first_name,
                                      :last_name,
                                      :email,
                                      :high_school,
                                      :tutor_id,
                                      :avatar)
    end
end
