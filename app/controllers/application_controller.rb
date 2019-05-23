class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  # ログイン済みユーザか確認
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to :login
    end
  end
end
