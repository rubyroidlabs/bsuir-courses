class CommentsController < ApplicationController
  before_action :find_ad
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def create
    @ad = Ad.find(params[:ad_id])
    @comment = @ad.comments.create(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to ad_path(@ad)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to ad_path(@ad)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to ad_path(@ad)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_ad
    @ad = Ad.find(params[:ad_id])
  end

  def find_comment
    @comment = @ad.comments.find(params[:id])
  end

end
