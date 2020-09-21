class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :new_guest, only: %i[update]

  def edit; end
 
  def update
    if @user.update(user_params)
      redirect_to profile_path, success: 'プロフィールを更新'
    else
      flash.now['danger'] =　'プロフィールを更新に失敗'
      render :edit
    end
  end

  def show; end
 
  private
 
  def set_user
    @user = User.find(current_user.id)
  end

 
  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :avatar)
  end

  def new_guest
    if current_user == User.find_by(email: 'test@example.com')
      redirect_to profile_path, success:'テストユーザーは変更できません。ログインが必要です'
    end
 end
end
