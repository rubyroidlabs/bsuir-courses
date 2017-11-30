class PostersController < ApplicationController

  before_action :find_poster, only: [:edit, :update, :show, :destroy]

  def new
    @poster = Poster.new 
  end

  def create
    @poster = Poster.new(poster_params)
    if @poster.save
      redirect_to posters_path
    else
      render :new
    end
  end

  def index
    @posters = Poster.all.paginate(page: params[:page], per_page: 6)
  end

  def edit
  end

  def update
    if @poster.update(poster_params)  
      redirect_to posters_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    if @poster.destroy
      redirect_to posters_path
    else
      redirect_to posters_path, error: 'Не получилось удалить объявление!!!'
    end
  end

  private
  def poster_params
    params[:poster].permit(:title, :description, :contacts)
  end

  def find_poster
    @poster = Poster.find(params[:id])
  end
end
