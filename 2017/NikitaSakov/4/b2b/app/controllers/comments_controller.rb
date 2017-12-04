class CommentsController < ApplicationController
  def create
     @publication = Publication.find(params[:publication_id])
     @comment = @publication.comments.create(comment_params)
     redirect_to publication_path(@publication)
  end
 
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
