class LessonPlansController < ApplicationController
  def new
    @lessonplan = LessonPlan.new
    @meeting = GroupMeeting.find(params[:group_meeting_id])
  end

  def index
    @tutor = Tutor.find(params[:tutor_id])
    @lessonplans = @tutor.lesson_plans
    @meetings = @tutor.site.group_meetings
  end

  def create
    @meeting = GroupMeeting.find(params[:group_meeting_id])
    @lessonplan = LessonPlan.create(tutor: current_user, group_meeting: @meeting, notes: params[:notes])
    @lessonplan.build_homework
    4.times do |n|
      @lessonplan.book_sections << BookSection.find(params["section#{n}"]) unless params["section#{n}"] == ""
      @lessonplan.homework.book_sections << BookSection.find(params["homework#{n}"]) unless params["homework#{n}"] == ""
    end
    @lessonplan.save
    render 'show'
  end

  def show
    @lessonplan = LessonPlan.find(params[:id])
    @homework = @lessonplan.homework
  end

  def edit
    @lessonplan = LessonPlan.find(params[:id])
    if @lessonplan.homework
      @homework_sections = @lessonplan.homework.book_sections.order(:start_page)
    else
      @homework_sections = []
    end
  end

  def update
    @lessonplan = LessonPlan.find(params[:id])
    @lessonplan.update_attributes(notes: params[:notes])
    @lessonplan.book_sections.destroy_all
    @lessonplan.homework.book_sections.destroy_all 
    4.times do |n|
      @lessonplan.book_sections << BookSection.find(params["section#{n}"]) unless params["section#{n}"] == ""
      @lessonplan.homework.book_sections << BookSection.find(params["homework#{n}"]) unless params["homework#{n}"] == ""
    end
    @lessonplan.save
    @homework = @lessonplan.homework
    render 'show'
  end


end
