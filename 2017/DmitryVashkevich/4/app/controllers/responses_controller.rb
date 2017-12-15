# ResponsesController
class ResponsesController < ApplicationController
  def create
    @advert = Advert.find(params[:advert_id])
    @response = @advert.responses.create(response_params)
    @response.create_user(user_params)
    redirect_to advert_path(@advert)
  end

  private

  def response_params
    params.require(:response).permit(:text)
  end

  def user_params
    params.require(:response).require(:person).permit(:name, :phone)
  end
end
