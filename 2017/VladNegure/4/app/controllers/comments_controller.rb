class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.create(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post }
      else
        format.html { redirect_to @post, alert: @comment.errors.full_messages }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
