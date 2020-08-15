class LikesController < ApplicationController
  def create
    @video = Video.find(params[:video_id])
    current_user.like(@video)
  end

  def destroy
    @video = current_user.likes.find(params[:id]).video
    current_user.notlike(@video)
  end
end
