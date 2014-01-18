class HomeworksController < ApplicationController

  def check_homework
    @hw = Homework.find(params[:id])
    @student = Student.find(params[:student_id])
  end

  def checked_homework
    @hw = Homework.find(params[:id])
    @student = Student.find(params[:student_id])
    @student.check_homework(@hw,params)
    @student.save
    render 'shared/homework_result'
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
          @hints[section] = @hints[section] << HwHint.best(q, @student, current_user, @assignment)
        end
      end
    end
    StudentMailer.hint_email(@student,@hw,@message, @hints).deliver
    flash[:success] = "Homework hint email sent to #{@student.first_name}."
    redirect_to current_user
  end



end
