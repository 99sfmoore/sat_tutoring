class SitesController < ApplicationController
  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    @site.add_students_from_file(params[:site][:student_file])
    @site.add_tutors_from_file(params[:site][:tutor_file])
    if @site.save
      redirect_to @site
    else
      render 'new'
    end
  end

  def show
    @site = Site.find(params[:id])
    @students = @site.students.sort_by{|s| s.tutor.first_name}
    @tests = Test.find([3,5])
    @test1_scores = @students.map {|s| s.scores.where(test_id: @tests.first).first}
    @test2_scores = @students.map {|s| s.scores.where(test_id: @tests.last).first}
  end

  def site_admin
    @site = Site.find(params[:id])
    if @site.team_leader != current_user
      redirect_to @site
    end
  end

  def import_answers
    @site = Site.find(params[:id])
  end

  def load_answers
    @site = Site.find(params[:id])
    test = Test.find(params[:test])
    @site.load_answers(test,params[:file].path)
    render 'show'
  end

  def enter_scores
    @site = Site.find(params[:id])
  end

  def entered_scores
    @site = Site.find(params[:id])
    test = Test.find(params[:test])
    test.enter_site_scores(@site, params)
    render 'show'
  end

  def make_registration_tickets
    @site = Site.find(params[:id])
  end

  def score_summary
    @site = Site.find(params[:id])
    @students = @site.students.sort_by{|s| s.tutor}
    @tests = [Test.find(3),Test.find(5)]
  end

  # def registration_tickets
  #   @site = Site.find(params[:id])
  #   @test = params(:test)
  #   @arrival = params(:arrival)
  #   @start = params(:start)
  #   render 'registration_tickets'

  # end

  private

    def site_params
      params.require(:site).permit(:name, :cp_contact_name, :cp_email)
    end
end
