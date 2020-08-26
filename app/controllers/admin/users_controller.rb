class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[edit update show destroy]
 
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end
 
  def edit; end
 
  def update
    if @users.update(user_params)
      redirect_to admin_user_path(@users), success: 'ユーザーを更新しました'
    else
      flash.now['denger'] = 'ユーザーの更新に失敗しました'
    end
  end
 
  def show; end
 
  def destroy
    @users.destroy!
    redirect_to admin_users_path, success: 'ユーザーを削除しました'
  end
 
  private
 
  def set_user
    @users = User.find(params[:id])
  end
 
  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :avatar, :avatar_cache, :role)
  end
end
