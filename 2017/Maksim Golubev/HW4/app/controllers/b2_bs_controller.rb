class B2BsController < ApplicationController
  before_action :set_b2_b, only: [:show, :edit, :update, :destroy]

  # GET /b2_bs
  # GET /b2_bs.json
  def index
    @b2_bs = B2B.all
  end

  # GET /b2_bs/1
  # GET /b2_bs/1.json
  def show
  end

  # GET /b2_bs/new
  def new
    @b2_b = B2B.new
  end

  # GET /b2_bs/1/edit
  def edit
  end

  # POST /b2_bs
  # POST /b2_bs.json
  def create
    @b2_b = B2B.new(b2_b_params)

    respond_to do |format|
      if @b2_b.save
        format.html { redirect_to @b2_b, notice: 'B2 b was successfully created.' }
        format.json { render :show, status: :created, location: @b2_b }
      else
        format.html { render :new }
        format.json { render json: @b2_b.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /b2_bs/1
  # PATCH/PUT /b2_bs/1.json
  def update
    respond_to do |format|
      if @b2_b.update(b2_b_params)
        format.html { redirect_to @b2_b, notice: 'B2 b was successfully updated.' }
        format.json { render :show, status: :ok, location: @b2_b }
      else
        format.html { render :edit }
        format.json { render json: @b2_b.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /b2_bs/1
  # DELETE /b2_bs/1.json
  def destroy
    @b2_b.destroy
    respond_to do |format|
      format.html { redirect_to b2_bs_url, notice: 'B2 b was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_b2_b
      @b2_b = B2B.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def b2_b_params
      params.require(:b2_b).permit(:title, :body, :phone, :name, :sell_currency)
    end
end
