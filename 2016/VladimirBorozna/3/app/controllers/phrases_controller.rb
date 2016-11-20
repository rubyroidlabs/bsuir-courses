class PhrasesController < ApplicationController #:nodoc:
  set :views, File.expand_path("../../views/phrases", __FILE__)

  get "/" do
    @phrases = Phrase.includes(:words).
               order("phrases.created_at DESC").
               order("words.word_id ASC")
    slim :index
  end

  get "/new" do
    partial(:modal) { slim :new, layout: false }
  end

  get "/show/:id" do
    @words = Word.where(phrase_id: params[:id]).
             order(created_at: :asc).
             includes(:user)
    slim :show
  end

  post "/create" do
    @phrase = Phrase.new(params)
    if @phrase.save
      notify_websocket_clients(@phrase.words.first)
      redirect_through_js("/")
    else
      response_json(400, error_messages(@phrase))
    end
  end

  get "/:id/words/new" do
    @phrase = Phrase.find(params[:id])
    partial(:modal) { slim :word_new, layout: false }
  end

  post "/:id/words/create" do
    @word = Word.new(params[:word])
    if @word.save
      notify_websocket_clients(@word)
      redirect_through_js("/show/#{params[:id]}")
    else
      response_json(400, error_messages(@word))
    end
  end

  private

  def notify_websocket_clients(word)
    json = JSON.generate(phrase_id: word.phrase_id,
                         word_content: word.content)
    websocket_clients.broadcast_message(json)
  end
end
