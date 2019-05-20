module SessionsHelper
  # 渡されたユーザでログインする
  def log_in(user)
    session[:user_id] = user.user_id
  end

  # 現在ログイン中のユーザを返す
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(user_id: session[:user_id])
    end
  end

  # ログインしているか
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
