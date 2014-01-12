class TutorsController < ApplicationController

  def show
    @tutor = Tutor.find(params[:id])
    

  end

  def edit
    @tutor = Tutor.find(params[:id])
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
    @tests = Test.find([3,5])
    @test1_scores = @students.map {|s| s.scores.where(test_id: @tests.first).first}
    @test2_scores = @students.map {|s| s.scores.where(test_id: @tests.last).first}
  end
end
