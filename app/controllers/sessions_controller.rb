# Session controller, creates/destroys session data
class SessionsController < ApplicationController
  # Skipping security filter for log in/out purposes
  skip_before_filter :authenticate_session, :only => [:new, :destroy, :create]

  def new
  end
  
  # Creates new session, sets cookies
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Zalogowano!"
    else
      flash.now.alert = "Niepoprawne dane"
      render "new"
    end
  end

  # Log out, destroys cookies
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Wylogowano!"
  end
end
