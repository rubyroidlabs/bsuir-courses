# controller for posters
class PostersController < ApplicationController
  before_action :set_poster, only: [:show]

  # GET /posters
  # GET /posters.json
  def index
    @posters = Poster.all
    @posters = Poster.order(created_at: :desc).page(params[:page])
  end

  # GET /posters/1
  # GET /posters/1.json
  def show
    @comment = Comment.new(poster: @poster)
    @comments = @poster.comments.order(created_at: :desc).page(params[:page])
  end

  # GET /posters/new
  def new
    @poster = Poster.new
  end

  # POST /posters
  # POST /posters.json
  def create
    @poster = Poster.new(poster_params)

    respond_to do |format|
      if @poster.save
        format.html { redirect_to action: :index, notice: 'Poster was successfully created.' }
        format.json { render :show, status: :created, location: @poster }
      else
        format.html { render :new }
        format.json { render json: @poster.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poster
      @poster = Poster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poster_params
      params.require(:poster).permit(:title, :text, :contact)
    end
end
