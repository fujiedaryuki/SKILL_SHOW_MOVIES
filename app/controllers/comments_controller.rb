class CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save!
  end

  def edit; end

  def update; end

  def destroy
    @comment.destroy!
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body).merge(video_id: params[:video_id])
  end
end
