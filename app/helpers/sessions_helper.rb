module SessionsHelper

  def sign_in(tutor)
    remember_token = Tutor.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    tutor.update_attribute(:remember_token, Tutor.encrypt(remember_token))
    self.current_user = tutor
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user=user
  end

  def current_user
    remember_token = Tutor.encrypt(cookies[:remember_token])
    @current_user ||= Tutor.find_by(remember_token: remember_token)
  end
end
