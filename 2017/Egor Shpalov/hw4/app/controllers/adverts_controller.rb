class AdvertsController < ApplicationController
  before_action :signed_in_user, only: [:show, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def show
    @advert = Advert.find(params[:id])
    @user = User.find(@advert.user_id)
    render 'adverts/show'
  end

  def create
    @advert = current_user.adverts.build(advert_params)
    if @advert.save
      flash[:success] = 'Adverticement posted!'
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @advert.destroy
    redirect_to root_url
  end

  private

  def advert_params
    params.require(:advert).permit(:content, :title)
  end

  def correct_user
    @advert = current_user.adverts.find_by(id: params[:id])
    redirect_to root_url if @advert.nil?
  end
end
