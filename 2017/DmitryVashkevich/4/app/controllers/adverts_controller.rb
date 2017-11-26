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
    respond_to do |format|
      if @advert.save
        format.html do
          redirect_to @advert,
                      notice: 'Advert was successfully created.'
        end
        format.json { render :show, status: :created, location: @advert }
      else
        format.html { render :new }
        format.json do
          render json: @advert.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /adverts/1
  # PATCH/PUT /adverts/1.json
  def update
    respond_to do |format|
      if @advert.update(advert_params)
        format.html do
          redirect_to @advert,
                      notice: 'Advert was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @advert }
      else
        format.html { render :edit }
        format.json do
          render json: @advert.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /adverts/1
  # DELETE /adverts/1.json
  def destroy
    @advert.destroy
    respond_to do |format|
      format.html do
        redirect_to adverts_url, notice: 'Advert was successfully destroyed.'
      end
      format.json { head :no_content }
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
