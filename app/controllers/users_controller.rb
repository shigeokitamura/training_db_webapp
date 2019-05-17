class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :root
    else
      render 'new'
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:user_id, :user_name, :age, :dept, :password, :password_confirmation)
  end
end

