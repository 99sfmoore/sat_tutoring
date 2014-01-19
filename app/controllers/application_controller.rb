class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :signed_in_user


  def signed_in_user
    unless signed_in?
      flash[:info] = "Please sign in"
      redirect_to signin_url
    end
  end
end
