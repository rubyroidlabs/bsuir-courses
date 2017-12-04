class PostsController < ApplicationController
  include PostIds
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end

  def show
    @comments = @post.comments.paginate(page: params[:page], per_page: 10)
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        add_post_id
        format.html { redirect_to @post }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    remove_post_id
    respond_to do |format|
      format.html { redirect_to posts_url }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :bonsticks, :bitcoins,
                                 :description, :contacts, :operation)
  end
end
