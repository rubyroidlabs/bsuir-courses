class PublicationsController < ApplicationController
  before_action :set_publication, only: [:show, :edit, :update, :destroy]

  def index
    @rate = ExchangeRates.take
    @publications = Publication.paginate(:page => params[:page], :per_page => 15)
  end

  def show
  end

  def new
    @publication = Publication.new
  end

  def edit
  end

  def create
    @publication = Publication.new(publication_params)

    respond_to do |format|
      if @publication.save
        format.html { redirect_to @publication, notice: 'Объявление успешно создано.' }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: 'Объявление успешно обновлено.' }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to publications_url, notice: 'Объявление успешно удалено.' }
      format.json { head :no_content }
    end
  end

  private
    def set_publication
      @publication = Publication.find(params[:id])
    end

    def publication_params
      params.require(:publication).permit(:caption, :text, :contacts)
    end
end
