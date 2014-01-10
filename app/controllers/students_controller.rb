

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
    @tests = Test.find([3,5])
    @segments = Segment.all
  end

  # def old_show
  #   @student = Student.find(params[:id])
  #   @tests = Test.all #do I need this?
  #   @test1 = Test.find(3)#MOVE THESE TO CONSTANTS
  #   @test2 = Test.find(5)
  #   @math = Segment.find_by_name("Math")
  #   @reading = Segment.find_by_name("Reading")
  #   @writing = Segment.find_by_name("Writing")
  #   @raw_math_1 = @student.raw_score(@test1, @math)
  #   @raw_math_2 = @student.raw_score(@test2, @math)
  #   @raw_reading_1 = @student.raw_score(@test1, @reading)
  #   @raw_reading_2 = @student.raw_score(@test2, @reading)
  #   @raw_writing_1 = @student.raw_score(@test1, @writing)
  #   @raw_writing_2 = @student.raw_score(@test2, @writing)
  # end

  def enter_answers 
    @student = Student.find(params[:id])
    @test = Test.find(params[:test])
  end

  def entered_answers
    @student = Student.find(params[:id])
    @test = Test.find(params[:test])
    @student.enter_answers(@test, params)
    @student.save
    render 'test_score'
  end

  def check_homework
    @student = Student.find(params[:id])
    @hw = BookSection.find(params[:hw])
  end

  def checked_homework
    @student = Student.find(params[:id])
    @hw = BookSection.find(params[:hw])
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

  def test_score_2
    @student = Student.find(params[:id])
    @test = Test.find(5)
    @raw_math_1 = @student.raw_score(Test.find(3),"Math")
    @raw_math_2 = @student.raw_score(Test.find(5),"Math")
    @raw_reading_1 = @student.raw_score(Test.find(3),"CR")
    @raw_reading_2 = @student.raw_score(Test.find(5),"CR")
    @raw_writing_1 = @student.raw_score(Test.find(3),"Writing")
    @raw_writing_2 = @student.raw_score(Test.find(5),"Writing")
    @questions = Hash.new{[]}
    @test.questions.each do |q|
      @questions[q.section] = @questions[q.section] << q
    end
    @questions.each do |k,v|
      v.sort_by! {|x| x.question_num}
    end
    render 'test_score_sum'
  end

  def hit_try_matrix
    @student = Student.find(params[:id])
    # conversion = Test.find_by_name("Basic Conversion Chart")
    conversion = Test.find(3)    
    raw_reading = @student.raw_score(Test.find(5),"CR")
    reading_attempts = 67.0 - raw_reading[:omitted]
    @reading_hit = (raw_reading[:correct]/reading_attempts * 100).round
    @reading_try = (reading_attempts/67.0*100).round
    start = (@reading_hit / 10 * 10) - 10
    @reading_hit_range = (start..100).step(10).to_a
    @reading_try_range = (50..100).step(5).to_a
    
    @reading_matrix = Array.new(@reading_hit_range.count) {Array.new(@reading_try_range.count)}
    @reading_matrix.each_with_index do |row,i|
      hit_rate = @reading_hit_range[i]/100.0
      row.each_with_index do |cell,j|
        try_rate = @reading_try_range[j]/100.0
        raw_score = (try_rate * 67 * hit_rate) - (0.25 * try_rate * 67 * (1-hit_rate))
        @reading_matrix[i][j] = conversion.scaled_score(raw_score,"CR")
      end
    end 
    raw_math = @student.raw_score(Test.find(5),"Math")
    math_attempts = 54.0 - raw_math[:omitted]
    @math_hit = (raw_math[:correct]/math_attempts * 100).round
    @math_try = (math_attempts/54.0*100).round
    start = (@math_hit / 10 * 10) - 10
    @math_hit_range = (start..100).step(10).to_a
    @math_try_range = (50..100).step(5).to_a
    
    @math_matrix = Array.new(@math_hit_range.count) {Array.new(@math_try_range.count)}
    @math_matrix.each_with_index do |row,i|
      hit_rate = @math_hit_range[i]/100.0
      row.each_with_index do |cell,j|
        try_rate = @math_try_range[j]/100.0
        raw_score = (try_rate * 54 * hit_rate) - (0.25 * try_rate * 54 * (1-hit_rate))
        @math_matrix[i][j] = conversion.scaled_score(raw_score,"Math")
      end
    end 
  end

  def segment_performance
    @test = Test.find(params[:test_id])
    @segment = Segment.find(params[:segment_id])
    @student = Student.find(params[:student_id])
    @performance = @test.performance(@student, @segment)
  end

  def send_test
    @student = Student.find(params[:id])
    StudentMailer.test_email(@student).deliver
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
