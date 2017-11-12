class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  # GET /words
  # GET /words.json
  def index
    @saying = Saying.find(params[:saying_id])
    @words = @saying.words
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @saying = Saying.find(params[:saying_id])
    @word = @saying.words.build(params[:word])
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words
  # POST /words.json
  def create
    @saying = Saying.find(params[:saying_id])
    @word = @saying.words.build(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to sayings_path, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @saying }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to sayings_path, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @saying }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to sayings_path, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @saying = Saying.find(params[:saying_id])
      @word = @saying.words.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.require(:word).permit(:user_word, :user_name, :saying_id)
    end
end
