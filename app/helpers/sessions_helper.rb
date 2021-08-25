module SessionsHelper
  def current_user 
    #ログイン中のユーザを取得するメソッドを定義
    #@current_userが真の場合はそのままにし、
    #偽の場合は右辺の値 User.find_by(id: session[:user_id]) を代入
    #またユーザーがログインしていればtrue、その他ならfalseを返すメソッドも定義。
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end
end