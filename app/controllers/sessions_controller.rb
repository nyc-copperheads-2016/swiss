# current params are dependant of how login form will be passing information, review prior to "done"
class SessionsController < ApplicationController
  skip_before_action :ensure_logged_in

  def new
  end

  def chrome_new
    render layout: false
  end

  def mlogin
    render layout: false
  end

  def chrome_logged_in
    render :json => current_user
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end