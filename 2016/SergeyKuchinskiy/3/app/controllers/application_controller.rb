require 'erb'
require 'date'
# ApplicationController
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, File.expand_path("", Dir.pwd) + '/app/public'
    set :views, File.expand_path("", Dir.pwd) + '/app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    # binding.pry
    if !logged_in?
      erb :signup_login, layout: nil
    else
      erb :index
    end
  end

  get '/log_out' do
    session[:user_id] = nil
    redirect to '/'
  end

  post '/sign_up' do
    @user = User.create(
      first_name: params['first_name'],
      last_name: params['last_name'],
      email: params['email'],
      password: params['password']
    )
    session[:user_id] = @user.id
    redirect to '/'
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
    end
    redirect to '/'
  end

  get "/new_phrase" do
    erb :new_phrase
  end

  post "/new_phrase" do
    word = params[:word]
    redirect to "/new_phrase" if word.match(/^[\w]+$/).nil?
    @phrase = Phrase.create(last_user: session[:user_id])
    Word.create(data: word, published_at: DateTime.now, user_id: session[:user_id], phrase_id: @phrase.id)
    redirect to "/"
  end

  get '/phrase/:id' do
    @phrase = Phrase.find(params[:id])
    erb :phrase_edit
  end

  post '/phrase/:id' do
    word = params[:word]
    redirect to "/phrase/#{params[:id]}" if word.match(/^[\w]+$/).nil?
    Word.create(data: word, published_at: DateTime.now, user_id: session[:user_id], phrase_id: params[:id])
    Phrase.find(params[:id]).update(last_user: session[:user_id])
    redirect to '/'
  end

  def logged_in?
    !session[:user_id].nil?
  end
end
