class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  def log_in(user)
    session[:user_id] = user.id
  end

  private

  def not_authenticated
    flash[:warning] = "ログインが必要です"
    redirect_to login_path
  end
end
