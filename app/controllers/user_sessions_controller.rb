class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to videos_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗'
      render :new 
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end