class HwHintsController < ApplicationController

  def new
    @hint = HwHint.new
    @question = Question.find(params[:question_id])
    session[:return_to] ||= request.referer
  end

  def create
    @question = Question.find(params[:question_id])
    @question.hw_hints.build(hw_hint_params)
    @question.save
    redirect_to session.delete(:return_to)
  end

  private
    def hw_hint_params
      params.require(:hw_hint).permit(:answer_choice,:hint)
    end
end
