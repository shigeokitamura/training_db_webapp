class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :correct_user, only: [:show]

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

  def show
    @user = User.find(params[:id])
    @orders = @user.buying
    @total = @orders.sum { |hash| hash[:price] }
  end

  def edit; end

  def update; end

  private

  def user_params
    # 最初のユーザはidは1、それ以降のidは最大値+1
    id = User.maximum('user_id').nil? ? 1 : User.maximum('user_id') + 1
    params.require(:user).
      permit(:user_name, :age, :dept, :password, :password_confirmation).
      merge(user_id: id)
  end

  # 正しいユーザか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
