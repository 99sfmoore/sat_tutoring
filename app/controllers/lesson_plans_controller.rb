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
    4.times do |n|
      @lessonplan.sections << Section.find(params["section#{n}"]) unless params["section#{n}"] == ""
      unless params["homework#{n}"] == ""
        hw_section = Section.find(params["homework#{n}"])
        hw = Homework.find_or_create_by(lessonplan: @lessonplan, segment: hw_section.segment)
        hw.sections << hw_section 
      end
    end
    @lessonplan.save
    redirect_to @lessonplan
  end

  def show
    @lessonplan = LessonPlan.find(params[:id])
    @homeworks = @lessonplan.homeworks
  end

  def edit
    @lessonplan = LessonPlan.find(params[:id])
    @homework_sections = []
    @lessonplan.homeworks.each do |hw|
      @homework_sections.concat(hw.sections)
    end
  end

  def update
    @lessonplan = LessonPlan.find(params[:id])
    @lessonplan.update_attributes(notes: params[:notes])
    @lessonplan.sections = []
    @lessonplan.homework.sections = []
    4.times do |n|
      @lessonplan.sections << Section.find(params["section#{n}"]) unless params["section#{n}"] == ""
      @lessonplan.homework.sections << Section.find(params["homework#{n}"]) unless params["homework#{n}"] == ""
    end
    @lessonplan.save
    @homework = @lessonplan.homework
    render 'show'
  end

  def homework_sheet
    @lessonplan = LessonPlan.find(params[:id])
    @homeworks = @lessonplan.homeworks
  end


end
