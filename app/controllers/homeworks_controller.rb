class HomeworksController < ApplicationController

  def check_homework
    @hw = Homework.find(params[:id])
    @student = Student.find(params[:student_id])
  end

  def show
    @hw = Homework.find(params[:id])
    if params[:student_id]
      @student = Student.find(params[:student_id])
      @students = [@student]
    elsif params[:tutor_id]
      @tutor = Tutor.find(params[:tutor_id])
      @students = @tutor.students
    end
  end

  def index
    if params[:student_id]
      @student = Student.find(params[:student_id])
      @hws = @student.past_homeworks
    elsif params[:tutor_id]
      @tutor = Tutor.find(params[:tutor_id])
      @hws = @tutor.homeworks.sort_by{|hw| hw.number}
    end
  end

  def checked_homework
    @hw = Homework.find(params[:id])
    @student = Student.find(params[:student_id])
    @student.check_homework(@hw,params)
    @student.save
    redirect_to [@student, @hw]
  end

  def send_hints
    @hw = Homework.find(params[:id])
    @student = Student.find(params[:student_id])
    @assignment = @hw.assignments.where("student_id = ?",@student.id).first
    @tutor = current_user
    @message_default = "Great job on the homework.  There are a few questions that I want you to look at again.  Please see the hints below.\n\nSee you soon!"
  end

  def send_email
    @hw = Homework.find(params[:id])
    @student = Student.find(params[:student_id])
    @assignment = @hw.assignments.where("student_id = ?",@student.id).first
    @message = params[:message]
    @hints = Hash.new{[]}
    @hw.sections.each do |section|
      section.questions.each do |q|
        unless q.correct?(@student)
          @hints[section] = @hints[section] << [q, HwHint.best_text(q, @student, current_user, @assignment)]
        end
      end
    end
    StudentMailer.hint_email(@student, current_user, @hw,@message, @hints).deliver
    flash[:success] = "Homework hint email sent to #{@student.first_name}."
    redirect_to current_user
  end

  def second_try
    @hw = Homework.find(params[:id])
    @student = Student.find(params[:student_id])
  end

  def second_checked_homework
    @hw = Homework.find(params[:id])
    @student = Student.find(params[:student_id])
    @student.check_second(@hw, params)
    @student.save
    redirect_to [@student, @hw]
  end



end
