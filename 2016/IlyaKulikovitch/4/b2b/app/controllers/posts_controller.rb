class PostsController < ApplicationController
  before_action :set_post, only: [:show,:edit, :update, :destroy]
  def index
  	@posts = Post.paginate(page: params[:page], per_page: 3)
  end

  def index_sale
    @posts = Post.where(exchange: '1').paginate(page: params[:page], per_page: 3)
  end

  def index_purchase
    @posts = Post.where(exchange: '2').paginate(page: params[:page], per_page: 3)
  end

  def show
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	if @post.save
  	  redirect_to @post, success: 'Объявление успешно создано'
  	else
  	  render :new
  	end
  end

  def edit
  end
  
  def update
    if @post.update_attributes(post_params)
      redirect_to @post, success: 'Объявление успешно обновлено'
    else 
      flash.now[:danger] = 'Объявление не обновлено'
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, success: 'Объявление успешно удалено'
  end

  private

  def post_params
    params.require(:post).permit(:title,:body,:cotacts,:exchange)
  end

  def set_post
  	@post = Post.find(params[:id])
  end

end