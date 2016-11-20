require 'sinatra'
require 'slim'
require_relative 'lib/data_storage.rb'

use Rack::Session::Cookie, key: 'session',
                           secret: 'DoYouKnowMySecret? =)'

helpers do
  def db
    DataStorage.instance
  end

  def acceptable_word?(word)
    word =~ /[A-Za-zА-Яа-я0-9]{1,20}[,!?:-]?/ && word.length < 32
  end

  def can_write?(phrase_id)
    db.user_can_write?(phrase_id, session[:username])
  end
end

get '/' do
  session[:last_url] = '/'
  @time = Time.now.to_s
  slim :index
end

get '/edit/:id/?' do
  session[:last_url] = "/edit/#{params['id']}"
  if db.phrase?(params['id'])
    @id = params['id']
    slim :edit
  else
    redirect to '/'
  end
end

post '/edit/:id/?' do
  if db.phrase?(params['id']) && session[:username] && can_write?(params['id'])
    if acceptable_word?(params['word'])
      db.add_word(params['id'], params['word'], session[:username])
    end
    redirect to "/edit/#{params['id']}"
  else
    redirect to '/'
  end
end

get '/new' do
  session[:last_url] = '/'
  if session[:username]
    slim :new_phrase
  else
    redirect to '/'
  end
end

post '/new' do
  if session[:username]
    if acceptable_word?(params['word'])
      id = db.create_phrase(params['word'], session[:username])
      redirect to "/edit/#{id}"
    else
      redirect to '/new'
    end
  else
    redirect to '/'
  end
end

post '/login' do
  if params['username'].strip =~ /\S.{1,28}\S/
    session[:username] = params['username']
  end
  redirect to session[:last_url] || '/'
end

get '/logout' do
  last_url = session[:last_url]
  session.delete(:username)
  redirect to last_url || '/'
end
