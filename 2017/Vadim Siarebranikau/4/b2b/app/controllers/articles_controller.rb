class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
   @articles=Article.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show; end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(articleparams)

    respond_to do |format|
      if @article.save
        format.html {
          redirect_to @article,
          notice: 'Article was successfully created.'
        }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json {
          render json: @article.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(articleparams)
        format.html {
          redirect_to @article,
          notice: 'Article was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json {
          render json: @article.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html {
        redirect_to articles_url,
        notice: 'Article was successfully destroyed.'
      }
      format.json { head :no_content }
    end
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def articleparams
      params.require(:article).permit(:title, :text, :contact)
    end
end
