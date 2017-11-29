# AdvertsController
class AdvertsController < ApplicationController
  before_action :set_advert, only: %i[show edit update destroy]

  # GET /adverts
  # GET /adverts.json
  def index
    @currency = params[:currency]
    @adverts = Advert.where(currency: @currency)
                     .order(created_at: :desc).page(params[:page]).per(10)
  end

  # GET /adverts/1
  # GET /adverts/1.json
  def show
    converter = ConverterService.new
    @price = converter.get_price(@advert.count, @advert.currency)
  end

  # GET /adverts/new
  def new
    @advert = Advert.new
  end

  # POST /adverts
  # POST /adverts.json
  def create
    @advert = Advert.new(advert_params)
    @advert.create_user(user_params)
    if @advert.save
      redirect_to @advert, notice: 'Advert was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /adverts/1
  # PATCH/PUT /adverts/1.json
  def update
    if @advert.update(advert_params)
      redirect_to @advert, notice: 'Advert was successfully updated.'
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_advert
    @advert = Advert.find(params[:id])
  end

  def advert_params
    params.require(:advert).permit(:tittle, :description, :currency, :count)
  end

  def user_params
    params.require(:advert).require(:person).permit(:name, :phone)
  end
end
