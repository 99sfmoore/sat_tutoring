class TestsController < ApplicationController
  def new
    @test = Test.new
  end

  def create 
    @test = Test.create(test_params)
    @test.assignable = true if params[:test][:assignable] == 1
    @test.load_questions_from_file(params[:test][:question_file], @test.assignable) if params[:test][:question_file]
    @test.set_conversion(params[:test][:conversion]) if params[:test][:conversion]
    if @test.save
      redirect_to @test
    else
      render 'new'
    end
  end

  def edit
    @test = Test.find(params[:id])
    if params[:student_id]
      @student = Student.find(params[:student_id]) 
      redirect_to enter_answers_test_student_path(@test, @student)
    end
  end

  def update
    @test = Test.find(params[:id])
    params[:assignable] ? assignable = true : assignable = false
    @test.update_attributes(assignable: assignable)
    @test.sections.each do |s|
      s.update_attributes(assignable: assignable)
    end
    @test.set_conversion(params[:conversion]) if params[:conversion]
    @test.save
    render 'show'
  end

  def show
    @test = Test.find(params[:id])
    if params[:student_id]
      @student = Student.find(params[:student_id]) 
      @students = [@student]
    elsif params[:tutor_id]
      @tutor = Tutor.find(params[:tutor_id])
      @students = @tutor.students
    end
  end

  def delete
  end





  private
    def test_params
      params.require(:test).permit(:name)
    end
end
