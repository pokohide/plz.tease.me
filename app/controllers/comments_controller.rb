class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.slide_id = params[:slide_id]
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
