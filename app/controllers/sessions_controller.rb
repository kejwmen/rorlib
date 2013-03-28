class SessionsController < ApplicationController
  skip_before_filter :authenticate_session, :only => [:new, :destroy, :create]
  def new
  end

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

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Wylogowano!"
  end
end
