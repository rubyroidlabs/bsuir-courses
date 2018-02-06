class UpdateController < ApplicationController
  def index
    UpdateBitcoinJob.perform_now
    redirect_to articles_path
  end
end
