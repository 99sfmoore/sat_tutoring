class SessionsController < ApplicationController
  skip_before_action :signed_in_user

  def new
  end

  def create
    tutor = Tutor.find_by(email: params[:session][:email].downcase)
    if tutor && tutor.authenticate(params[:session][:password])
      sign_in tutor
      flash[:success] = "Welcome, #{tutor.first_name}!"
      redirect_to tutor
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
