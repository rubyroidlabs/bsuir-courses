class StaticPagesController < ApplicationController
  def home
    @advert = current_user.adverts.build if signed_in?
  end
end
