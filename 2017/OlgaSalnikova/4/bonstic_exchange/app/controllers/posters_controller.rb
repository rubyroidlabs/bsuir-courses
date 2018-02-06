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
        format.html { redirect_to action: :index, notice: t('notices.poster.success_create') }
        format.json { render :show, status: :created, location: @poster }
      else
        format.html { render :new }
        format.json { render json: @poster.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_poster
    @poster = Poster.find(params[:id])
  end

  def poster_params
    params.require(:poster).permit(:title, :text, :contact)
  end
end
