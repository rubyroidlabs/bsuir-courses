class SellPostsController < ApplicationController
  before_action :set_sell_post, only: [:show, :destroy]

  # GET /sell_posts
  # GET /sell_posts.json
  def index
    @sell_posts = SellPost.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /sell_posts/1
  # GET /sell_posts/1.json
  def show
  end

  # GET /sell_posts/new
  def new
    @sell_post = SellPost.new
  end

  # POST /sell_posts
  # POST /sell_posts.json
  def create
    @sell_post = SellPost.new(sell_post_params)

    respond_to do |format|
      if @sell_post.save
        format.html { redirect_to @sell_post, notice: 'Sell post was successfully created.' }
        format.json { render :show, status: :created, location: @sell_post }
      else
        format.html { render :new }
        format.json { render json: @sell_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sell_posts/1
  # DELETE /sell_posts/1.json
  def destroy
    @sell_post.destroy
    respond_to do |format|
      format.html { redirect_to sell_posts_url, notice: 'Sell post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sell_post
      @sell_post = SellPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sell_post_params
      params.require(:sell_post).permit(:title, :body, :phone, :name, :sell_currency)
    end
end
