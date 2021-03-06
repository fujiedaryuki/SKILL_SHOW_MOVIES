class VideosController < ApplicationController
  
  def index
    @q = Video.ransack(params[:q])
    @videos = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
    @head_videos = Video.includes(:user).order(created_at: :desc)
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

  def likes
    @q =  current_user.like_videos.ransack(params[:q])
    @like_videos = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def my_videos
    @q =  current_user.videos.ransack(params[:q])
    @videos = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  private

  def video_params
    params.require(:video).permit(:title, :body, :video_image, :video_image_cache)
  end
end