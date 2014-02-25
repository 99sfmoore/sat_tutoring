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

  def edit
    @site = Site.find(params[:id])
  end

  def update
    @site = Site.find(params[:id])
    @site.update_attributes(site_params)
    redirect_to @site
  end

  def show
    @site = Site.find(params[:id])
    @students = @site.students.sort_by{|s| s.tutor.first_name}
    @tests = Test.kaplan
    @scores = Hash.new
    @students.each do |s|
      @scores[s] = Hash.new
      @tests.each do |t|
        @scores[s][t] = s.scores.find_by(test: t)
      end
    end
  end

  def site_admin
    @site = Site.find(params[:id])
    unless current_user == @site.team_leader || current_user.admin?
      redirect_to @site
    end
  end

  def contact
    @site = Site.find(params[:id])
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

  def write_group_email
    @site = Site.find(params[:id])
    session[:return_to] = request.referer
  end

  def send_group_email
    site = Site.find(params[:id])
    subject = params[:subject]
    message = params[:message]
    StudentMailer.group_email(site, subject, message).deliver
    redirect_to session.delete(:return_to)
  end 

  def write_picture_emails
    @site = Site.find(params[:id])
    session[:return_to] = request.referer
  end

  def send_picture_emails
    site = Site.find(params[:id])
    message = params[:message]
    site.students.each do |s|
      StudentMailer.picture_email(s, message).deliver
    end
    redirect_to session.delete(:return_to)
  end 




  def raw_scores
    @site = Site.find(params[:id])
    @students = @site.students.sort_by{|s| s.tutor.first_name}
    @tests = Test.kaplan
    @scores = Hash.new
    @students.each do |s|
      @scores[s] = Hash.new
      @tests.each do |t|
        @scores[s][t] = s.raw_scores.find_by(test: t)
      end
    end
  end

  def score_reports
    @site = Site.find(params[:id])
    @students = @site.students
    @tests = Test.kaplan
    @segments = Segment.all_test
    render 'shared/score_reports'
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
      params.require(:site).permit(:name, :abbreviation, :cp_contact_name, :cp_email)
    end
end
