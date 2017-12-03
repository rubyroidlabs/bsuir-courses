class ArticlesController < ApplicationController
  def index
    @article = Article.order('created_at DESC').page(params[:page]).per(15)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to @article
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :name, :number)
  end

end
