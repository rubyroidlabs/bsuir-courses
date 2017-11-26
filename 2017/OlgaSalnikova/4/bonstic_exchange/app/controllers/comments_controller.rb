# controller for comment
class CommentsController < ApplicationController
  before_action :set_poster, only: [:index, :create]

  def index
    redirect_to poster_path(@poster)
  end

  def create
    @comment = @poster.comments.build(comment_params)
    @comments = @poster.comments.order(created_at: :desc).page(params[:page])

    if @comment.save
      redirect_to poster_path(@poster)
    else
      render 'posters/show'
    end
  end

  private

  def set_poster
    @poster = Poster.find(params[:poster_id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :contact)
  end
end
