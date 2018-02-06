class CommentsController < ApplicationController

  before_action :find_poster, only: [:create, :destroy]

  def create
    @comment = @poster.comments.create(params[:comment].permit(:content))
    redirect_to poster_path(@poster)
  end

  def destroy
    @comment = @poster.comments.find(params[:id])
    @comment.destroy
    redirect_to poster_path(@poster)
  end

  private

  def find_poster
    @poster = Poster.find(params[:poster_id])
  end

end
