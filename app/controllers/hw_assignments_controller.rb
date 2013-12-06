class HwAssignmentsController < ApplicationController

  def show
    @hw = HwAssignment.find(params[:id])
    @student = Student.find(params[:student_id])
    render 'shared/homework_result'
  end

  def send_hints
    @hw = HwAssignment.find(params[:id])
    @student = Student.find(params[:student_id])
    @tutor = Tutor.find(1) # CHANGE THIS FOR LOGGED IN TUTOR
  end

end
