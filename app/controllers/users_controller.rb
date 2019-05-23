class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to :root
    else
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  private

  def user_params
    id = User.maximum('user_id') + 1
    params.require(:user).
      permit(:user_name, :age, :dept, :password, :password_confirmation).
      merge(user_id: id)
  end
end
