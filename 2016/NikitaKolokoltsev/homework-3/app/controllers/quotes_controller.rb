# Quotes Controller
class QuotesController < ApplicationController
  WORD_REGEX = /^[\w\d]+[;,:&\(\)\[\]\{\}=+-]?$/

  get "/quotes/new" do
    if !request.websocket?
      if user_signed_in?
        slim :quotes_new
      else
        redirect_to_root_path
      end
    else
      create_web_socket_connection
    end
  end

  post "/quotes/new" do
    if params[:text] =~ WORD_REGEX
      quote = current_user.quotes.create
      Word.create(user: current_user, quote: quote, text: params[:text])
      quote.update!(last_user_edited: current_user.id)
      redirect_to_root_path
    else
      slim :quotes_new
    end
  end

  get "/quotes/edit/:id" do
    if user_signed_in?
      @quote = Quote.includes(:words).find(params[:id])
      @disable_input = true if @quote.words.last.user.id == current_user.id
      slim :quotes_edit
    else
      redirect_to_root_path
    end
  end

  post "/quotes/edit/:id" do
    if params[:text] =~ WORD_REGEX
      quote = Quote.find(params[:id])
      Word.create(quote: quote, user: current_user, text: params[:text])
      quote.update!(last_user_edited: current_user.id)
      redirect_to_root_path
    else
      slim :quotes_edit
    end
  end
end
