# encoding: utf-8

=begin
Main application controller


=end
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_charset
  
  #setting global charset to unicode (utf-8)
  def set_charset
    response.headers['Content-Type'] = "text/html; charset=utf-8"
  end
  before_filter :authenticate_session

  private

  # Method used to check if current user is logged in
  def authenticate_session
    unless !current_user.nil?
      flash[:error] = "Nie jestes zalogowany!"
      redirect_to '/sessions/new'
    end
  end
  # Method used to check if logged in user has an admin permission
  def is_admin?
    unless !(current_user.permissions != "admin")
      flash[:error] = "Nie masz uprawnień"
      redirect_to :back
    end
  end
  # Variable which contains logged in user data. If user is not logged in, variable is empty.
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
