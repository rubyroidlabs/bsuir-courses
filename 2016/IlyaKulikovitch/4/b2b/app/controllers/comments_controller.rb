class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    #@comment = @post.comments.create(params[:comment])
    @comment = @post.comments.create!(params.require(:comment).permit!) 
    redirect_to post_path(@post), success: 'Комментарий успешно добавлен.'
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), info: 'Комментарий успешно удален.'
  end
end
