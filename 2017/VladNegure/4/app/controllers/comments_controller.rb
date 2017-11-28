class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.create(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post }
      else
        format.html { redirect_to @post, alert: 'Must have at least 5 symbols' }
      end
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
