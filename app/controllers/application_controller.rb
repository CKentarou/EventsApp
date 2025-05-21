class ApplicationController < ActionController::Base
  before_action :authenticate
  helper_method :logged_in?, :current_user

  allow_browser versions: :modern

  private

  def logged_in?
    !!current_user
  end

  def current_user
    return unless session[:user_id]
    return if User.count.zero?
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def authenticate
    return if logged_in?
    redirect_to root_path, alert: "ログインしてください"
  end
end
