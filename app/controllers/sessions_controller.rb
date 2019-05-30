class SessionsController < ApplicationController
  def new
    session[:after_login] = Rails.application.routes.recognize_path(request.referer)
  end

  def create
    user = User.find_by(user_name: params[:session][:user_name])
    if user&.authenticate(params[:session][:password])
      log_in user
      if session[:after_login]
        redirect_to session[:after_login]
        session[:after_login] = nil
      end
    else
      flash.now[:danger] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to Rails.application.routes.recognize_path(request.referer)
  end
end
