class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(user_name: params[:session][:user_name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to :root
    else
      flash.now[:danger] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to :root
  end
end
