require_relative 'models/user.rb'
require_relative 'models/phrase.rb'
require_relative 'models/word.rb'
require 'sinatra'
require 'time'
require 'active_record'
require 'sinatra/base'

# TODO:
class Application < Sinatra::Base
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/database.sqlite'
  )
  configure do
    enable :sessions
  end

  get '/' do
    redirect '/login'
  end

  get '/login' do
    slim :login
  end

  post '/dologin' do
    if params[:firstname].empty? | params[:secondname].empty?
      redirect '/login'
    elsif User.exists?(params)
      @user = User.find_by(params)
      session[:user_id] = @user.id
      redirect '/game'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/game'
    end
  end

  get '/game' do
    redirect '/login' if session[:user_id].eql?(nil)
    slim :game
  end

  post '/add_phrase' do
    redirect '/login' if session[:user_id].eql?(nil)
    if params[:phrase].empty? || !valid?(params[:phrase])
      # TODO: alert msg
      redirect '/game'
    else
      @phrase = Phrase.create(user_id: session[:user_id], created_at: Time.now.asctime, value: params[:phrase], last_changer: session[:user_id])
      Word.create(phrase_id: @phrase.id, user_id: session[:user_id], added_at: Time.now.asctime, value: params[:phrase])
    end
    redirect '/game'
  end

  get '/phrase/:id' do
    redirect '/login' if session[:user_id].eql?(nil)
    slim :phrase
  end

  post '/phrase/:id/edit' do
    redirect '/login' if session[:user_id].eql?(nil)
    if params[:word].empty? || !valid?(params[:word])
      # TODO: alert msg
      redirect "/phrase/#{params[:id]}"
    else
      Word.create(phrase_id: params[:id], user_id: session[:user_id], added_at: Time.now.asctime, value: params[:word])
      phrase = Phrase.find params[:id]
      phrase.value = [phrase.value, params[:word]].reject(&nil).to_a.join(' ')
      phrase.last_changer = session[:user_id]
      phrase.save
      redirect "/phrase/#{params[:id]}"
    end
  end

  not_found do
    status 404
    slim :not_found
  end

  helpers do
    def valid?(word)
      word =~ /^[\w\d]+[;,:&\(\)\[\]\{\}=+-]?$/
    end
  end
end

Application.run!
