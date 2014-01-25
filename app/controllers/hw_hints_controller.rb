class HwHintsController < ApplicationController

  def new
    @hint = HwHint.new
    @question = Question.find(params[:question_id])
    session[:return_to] ||= request.referer
  end

  def create
    @question = Question.find(params[:question_id])
    hint = @question.hw_hints.build(hw_hint_params)
    hint.update_attributes(tutor: current_user)
    redirect_to session.delete(:return_to)
  end

  def edit
    @hint = HwHint.find(params[:id])
    @question = @hint.question
    session[:return_to_2] = request.referer
  end

  def update
    @hint = HwHint.find(params[:id])
    @hint.update_attributes(hw_hint_params)
    redirect_to session.delete(:return_to_2)
  end

  def index
    @question = Question.find(params[:question_id])
    @assignment = Assignment.find(params[:assignment_id])
    @student = @assignment.student
    @hint = HwHint.new
    session[:return_to] ||= request.referer
  end

  def choose_hint
    @question = Question.find(params[:question_id])
    @assignment = Assignment.find(params[:assignment_id])
    @student = @assignment.student
    if params[:hint] == "new"
      @hint = HwHint.create(answer_choice: params["answer_choice"], 
                            hint: params["hint_text"],
                            question: @question,
                            tutor: current_user)
    else
      @hint = HwHint.find(params["hint"])
    end
    current = @assignment.hw_hints.where("question_id = ?",@question.id).first
    unless current == @hint
      @assignment.hw_hints.delete(current) unless current.nil?
      @assignment.hw_hints << @hint
    end
    @assignment.save
    redirect_to session.delete(:return_to)
  end


  private
    def hw_hint_params
      params.require(:hw_hint).permit(:answer_choice,:hint)
    end
end
