class PostsController < ApplicationController
  include PostIds
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments.paginate(page: params[:page], per_page: 10)
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  # POST /posts.json
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

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    remove_post_id
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
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
