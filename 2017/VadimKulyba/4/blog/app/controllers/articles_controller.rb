# controller
class ArticlesController < ApplicationController
  http_basic_authenticate_with name: 'vadim', password: '12345',
                               except: %i[index show new create]

  def index
    @articles = Article.order(:updated_at).page params[:page]
  end

  # id with url
  def show
    @article = Article.find(params[:id])
  end

  # return empty article on page
  def new
    @article = Article.new
  end

  # return articles on id for page
  def edit
    @article = Article.find(params[:id])
  end

  # post request with form (params)
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      # return on new action
      render 'new'
    end
  end

  # post request with form(find article on id and upgrade with params)
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      # for validation
      render 'edit'
    end
  end

  # delete method (with id)
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

  # for security
  def article_params
    params.require(:article).permit(:title, :text, :info)
  end
end
