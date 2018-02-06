class ArticlesController < ApplicationController
  attr_reader :btc_byr
  def initialize
    ArticlesController.update_btc_byr
    super
  end

  def index
    @articles = Article.order(:updated_at).page params[:page]
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'new'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  def update_btc_byr
    @btc_byr = YAML.safe_load(File.open("#{Rails.root}/config/btc_byr.yml"))
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
