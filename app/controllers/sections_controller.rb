class SectionsController < ApplicationController

  def new
    @section = Section.new
  end

  def create
    if params[:section][:tel_list_file].nil?
      @section = Section.new(section_params)
    else
      Section.make_from_file(params[:section][:tel_list_file])
    end
    redirect_to 'index'
  end

  def index
    @sections = Section.order(:start_page)
  end


  def show
    @section = Section.find(params[:id])
    @student = Student.find(params[:student_id])
    render 'shared/homework_result'
  end

  def edit_questions
    @section = Section.find(params[:id])
  end

  def update_questions
    @section = Section.find(params[:id])
    @section.questions.each do |q|
      q.update_attributes(correct_answer: params[q.id.to_s].upcase)
    end
    @section.save
  end

  def send_hints
    @section = Section.find(params[:id])
    @student = Student.find(params[:student_id])
    @tutor = current_user
    @message_default = "Great job on the homework.  There are a few questions that I want you to look at again.  Please see the hints below.\n\nSee you soon!"
  end

  def send_email
    @section = Section.find(params[:id])
    @student = Student.find(params[:student_id])
    @message = params[:message]
    @hints = []
    @section.questions.each do |q|
      unless q.correct?(@student)
        @hints << q.hw_hints.first
      end
    end
    StudentMailer.hint_email(@student,@section,@message, @hints).deliver
    flash[:success] = "Homework hint email sent to #{@student.first_name}."
    redirect_to current_user
  end

  # def section_params #this is wrong
  #     params.require(:section).permit(:category_id,
  #                                     :section_num,
  #                                     :start_page,
  #                                     :end_page,
  #                                     :num_of_questions)
  #   end



end
