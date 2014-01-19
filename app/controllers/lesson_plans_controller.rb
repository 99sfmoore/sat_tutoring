class LessonPlansController < ApplicationController
  def new
    @lessonplan = LessonPlan.new
    @meeting = GroupMeeting.find(params[:group_meeting_id])
    session[:return_to] ||= request.referer
  end

  def index
    @tutor = Tutor.find(params[:tutor_id])
    @lessonplans = @tutor.lesson_plans
    @meetings = @tutor.site.group_meetings
  end

  def create
    @meeting = GroupMeeting.find(params[:group_meeting_id])
    @lessonplan = LessonPlan.create(tutor: current_user, group_meeting: @meeting, notes: params[:notes], other_hw: params[:other_hw], post_notes: params[:post_notes])
    4.times do |n|
      @lessonplan.sections << Section.find(params["section#{n}"]) unless params["section#{n}"] == ""
      unless params["homework#{n}"] == ""
        hw_section = Section.find(params["homework#{n}"])
        hw = Homework.find_or_create_by(lesson_plan: @lessonplan, segment: hw_section.segment)
        hw.sections << hw_section 
      end
    end
    @lessonplan.save
    redirect_to session.delete(:return_to)
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
    session[:return_to] ||= request.referer
  end

  def update
    @lessonplan = LessonPlan.find(params[:id])
    @lessonplan.update_attributes(notes: params[:notes], other_hw: params[:other_hw], post_notes: params[:post_notes])
    @lessonplan.sections = []
    hw_sections = []
    4.times do |n|
      @lessonplan.sections << Section.find(params["section#{n}"]) unless params["section#{n}"] == ""
      hw_sections << Section.find(params["homework#{n}"]) unless params["homework#{n}"] == ""
    end
    hw_segments = hw_sections.group_by {|sec| sec.segment}
    @lessonplan.homeworks.each do |hw|
      if hw_segments[hw.segment]
        hw.sections = hw_segments[hw.segment]
      else
        hw.destroy
      end
    end
    hw_segments.each do |segment, sections|
      hw = Homework.find_or_create_by(lesson_plan: @lessonplan, segment: segment)
      hw.sections = sections
      hw.save
    end 
    @lessonplan.save
    redirect_to session.delete(:return_to)
  end

  def homework_sheet
    @lessonplan = LessonPlan.find(params[:id])
    @homeworks = @lessonplan.homeworks
  end


end
