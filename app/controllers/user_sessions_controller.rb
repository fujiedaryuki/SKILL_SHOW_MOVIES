class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create new_guest]

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

  def new_guest
    user = User.find_by(email: 'test@example.com')
    log_in(user)
    flash[:success] = 'ゲストユーザーでログインしました'
    flash[:warning] = 'よろしくお願いします！'
    redirect_to videos_path(user)
  end

end
