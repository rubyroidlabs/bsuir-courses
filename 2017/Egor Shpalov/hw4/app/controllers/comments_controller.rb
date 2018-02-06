class CommentsController < ApplicationController
  before_action :signed_in_user,           only: %i[create destroy]
  before_action :fetch_advert_for_create,  only: :create
  before_action :correct_user,             only: :destroy

  def create
    @comment = @advert.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to advert_path(id: @advert.id)
    else
      redirect_to root_url
    end
  end

  def destroy
    @comment.destroy
    redirect_to root_url
  end

  private

  def fetch_advert_for_create
    @advert = Advert.find_by(id: params[:comment][:advert_id].to_s)
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end

  def correct_user
    @comment = Comment.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end
