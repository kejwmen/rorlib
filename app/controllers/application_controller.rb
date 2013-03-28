class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_charset

  def set_charset
    response.headers['Content-Type'] = "text/html; charset=utf-8"
  end
  before_filter :authenticate_session

  private
  def authenticate_session
    unless !current_user.nil?
      flash[:error] = "Nie jestes zalogowany!"
      redirect_to '/sessions/new'
    end
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
