class TutorsController < ApplicationController

  def new
    redirect_to root_path unless current_user.admin? || current_user.leader?
    @tutor = Tutor.new
  end

  def create
    redirect_to root_path unless current_user.admin? || current_user.leader?
    @tutor = Tutor.create(tutor_params)
  end

  def show
    @tutor = Tutor.find(params[:id])
  end

  def edit
    @tutor = Tutor.find(params[:id])
    redirect_to root_path unless current_user == @tutor || current_user.admin? || current_user.leader?
  end

  def update
    @tutor = Tutor.find(params[:id])
    redirect_to root_path unless current_user == @tutor || current_user.admin? || current_user.leader?
    @tutor.update_attributes(tutor_params)
    render 'show'
  end

  def index
    #sometimes nested within site
    if params[:site_id]
      @site = Site.find(params[:site_id])
      @tutors = @site.tutors.sort_by {|t| t.first_name}
    else
      #non - nested case
    end
  end

  def show_scores
    @tutor = Tutor.find(params[:id])
    @students = @tutor.students
    @tests = Test.kaplan
    @scores = Hash.new
    @students.each do |s|
      @scores[s] = Hash.new
      @tests.each do |t|
        @scores[s][t] = s.scores.find_by(test: t)
      end
    end
  end

  def segment_performance
    @test = Test.find(params[:test_id])
    @segment = Segment.find(params[:segment_id])
    @tutor = Tutor.find(params[:tutor_id])
    @performance = @test.performance(@tutor.students, @segment)
  end

  private
   
    def tutor_params
      params.require(:tutor).permit(:first_name,:last_name,:email, :email_for_students, :site_id, :password, :password_confirmation)
    end
end
