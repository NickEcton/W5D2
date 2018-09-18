class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def login(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def logout!
    self.current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end
end
