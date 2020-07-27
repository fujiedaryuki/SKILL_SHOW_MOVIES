class VideosController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  def index
    @videos = Video.all.includes(:user).order(created_at: :desc)
  end

  def new
    @video = Video.new
  end


  def create
    @video = current_user.videos.build(video_params)
    if @video.save
      redirect_to videos_path, success: "投稿動画作成"
    else
      flash.now['danger'] = "投稿動画作成が失敗しました"
      render :new
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  private

  def video_params
    params.require(:video).permit(:title, :body, :video_image, :video_image_cache)
  end
end
