class PostsController < ApplicationController
  def index
    #@posts = Post.all
    @posts = Post.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :text, :contact_information, :kind, :item)
    end
end
