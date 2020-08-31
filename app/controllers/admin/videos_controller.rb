class Admin::VideosController < Admin::BaseController
  before_action :set_video, only: %i[edit update show destroy]
 
  def index
    @q = Video.ransack(params[:q])
    @videos = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end
 
  def edit; end
 
  def update
    if @videos.update(video_params)
      redirect_to admin_video_path(@videos), success: '動画詳細を更新しました'
    else
      flash.now['danger'] = '動画詳細の更新に失敗しました'
      render :edit
    end
  end
 
  def show; end
 
  def destroy
    @videos.destroy!
    redirect_to admin_videos_path, success: '動画を削除しました'
  end
 
  private
 
  def set_video
    @videos = Video.find(params[:id])
  end
 
  def video_params
    params.require(:video).permit(:title, :body, :video_image, :video_image_cache)
  end
end
