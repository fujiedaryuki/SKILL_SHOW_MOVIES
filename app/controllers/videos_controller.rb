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
    @comment = Comment.new
    @comments = @video.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @video = current_user.videos.find(params[:id])
  end

  def update
    @video = current_user.videos.find(params[:id])
    if @video.update(video_params)
      redirect_to video_path, success: '更新しました'
    else
      flash.now['danger'] = '更新に失敗'
      render :edit
    end

  end
   
  def destroy
    @video = current_user.videos.find(params[:id])
    @video.destroy!
    redirect_to videos_path, success: '削除しました'
  end

  private

  def video_params
    params.require(:video).permit(:title, :body, :video_image, :video_image_cache)
  end
end
