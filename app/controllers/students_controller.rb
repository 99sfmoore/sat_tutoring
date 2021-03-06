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
    @tests = Test.kaplan_taken(@student)
    @segments = Segment.all_test
    @scores = @student.scores.group_by{|s| s.test}
  end

  def index
    #sometimes nested within site
    if params[:site_id]
      @site = Site.find(params[:site_id])
      @students = @site.students.sort_by {|s| s.tutor.first_name}
    else
      #non - nested case
    end
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
    @test = Test.find(params[:test_id])
    @questions = @test.questions.sort_by {|q| [q.section.section_num, q.question_num]}
  end

  def entered_answers
    @student = Student.find(params[:id])
    @test = Test.find(params[:test_id])
    @student.enter_answers(@test, params)
    @student.save
    render 'test_score'
  end

  def check_homework
    @student = Student.find(params[:id])
    @hw = Homework.find(params[:homework_id])
  end

  def checked_homework
    @student = Student.find(params[:id])
    @hw = Homework.find(params[:homework_id])
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
    @test = Test.find(params[:test_id])
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
    @conversion = Test.find_by_name("Basic Conversion Chart")
    @segments = Segment.all_test
    @tests = Test.kaplan_taken(@student)
    @boxes = Hash.new{Array.new}
    @try_range = Hash.new{(50..100).step(5).to_a}
    @hit_range = Hash.new{(50..100).step(10).to_a}
    @segments.each do |seg|
      @tests.each do |test|
        try = @student.try_rate(test,seg)
        hit = @student.hit_rate(test,seg)
        if @student.full_name == "Kawan Hernandez"
          @try_range[seg] = (20..100).step(10).to_a
          @hit_range[seg] = (20..80).step(10).to_a
          @boxes[seg] = @boxes[seg] << [hit.round(-1),(try/10.0).round*10]
        else
          @try_range[seg] = ((try/5 * 5)..100).step(5).to_a if try < @try_range[seg].first
          @hit_range[seg] = ((hit/10 * 10)..100).step(10).to_a if hit < @hit_range[seg].first
          @boxes[seg] = @boxes[seg]<< [hit.round(-1),(try/5.0).round*5]
        end
      end
    end
  end

  def segment_performance
    @test = Test.find(params[:test_id])
    @segment = Segment.find(params[:segment_id])
    @student = Student.find(params[:student_id])
    @performance = @test.performance([@student], @segment)
  end

  def send_test
    @student = Student.find(params[:id])
    StudentMailer.test_email(@student).deliver
  end

  def scaled_scores
    @student = Student.find(params[:id])
    @tests = Test.kaplan
    @segments = Segment.all_test
    @scores = @student.scores.group_by{|s| s.test}
    @raw_scores = @student.raw_scores.group_by{|s| s.test}
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
