class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @slide = current_user.slides.find_by(id: params[:slide_id])
    @comment = @slide.comments.new(comment_params)
    @comment.user = current_user
    @err = @comment.save ? false : true
    render
  end

  def destroy
    @comment = current_user.comments.find_by(id: params[:id])
    @comment.destroy
    render
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
