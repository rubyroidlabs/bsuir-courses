
require "sinatra"
require "sinatra/activerecord"
require "active_record"
require "slim"
require "unicode"
require "sinatra/flash"
require "bootstrap-sass"
require "sass"
require "i18n"
require "i18n/backend/fallbacks"
#require "rack/contrib"

configure :development do
  set :database, { adapter: "sqlite3", database: "./db/db.sqlite" }
end

configure :production do
  ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "postgres://localhost/mydb")
end

configure do
  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
  I18n.load_path = Dir[File.join(settings.root, "locales", "*.yml")]
  I18n.backend.load_translations
  I18n.default_locale = :ru
  enable :sessions
  #use Rack::Locale
end

get "/"  do
  if session[:name].nil?
    @title = "Login"
    slim :login
  else
    @title = "Все статьи"
    slim :index
  end
end

post "/dologin" do
  create_user
end

get "/users" do
  @title = "Пользователи"
  @users = User.all
  slim :users
end

get "/add_phrase" do
  @title = "Добавить фразу"
  slim :add_phrase
end

get "/add_word/:id" do
  @title = "Добавить слово"
  slim :add_word
end

post "/submit_phrase" do
  create_phrase
end

post "/submit_word/:id" do
  update_phrase
  redirect "/"
end

get "/custom.css" do
  scss :custom
end

def create_phrase
  if word_valid?(params[:phrase])
    User.find_by(name: session[:name].to_s).phrases.create phrase: Unicode::capitalize(params[:phrase])
    flash[:success] = "Вы успешно добавили фразу!"
    redirect_root
  else
    flash[:danger] = @word.errors.full_messages.to_sentence
    redirect "/add_phrase"
  end
end

def create_user
  if user_valid?
    User.create(params)
    session[:name] = params[:name]
    session[:user_id] = User.find_by(name: params[:name]).id
    flash[:success] = "Вы успешно вошли, #{session[:name]}!"
    redirect_root
  else
    flash[:danger] = @user.errors.full_messages.to_sentence
    redirect_root
  end
end

def update_phrase
  if word_valid?(params[:word])
    word = params[:word]
    phrase = Phrase.find_by(id: params[:id]).phrase
    Phrase.find_by(id: params[:id]).update phrase: phrase << " " << word, user_id: session[:user_id]
    flash[:success] = "Вы успешно обновили фразу!"
  else
    flash[:danger] = @word.errors.full_messages.to_sentence
    redirect "/add_word/#{params[:id]}"
  end
end

def create_word
  User.find_by(name: session[:name].to_s).words.create word: (params[:word])
end

def user_valid?
  @user = User.new(name: params[:name])
  @user.validate
  User.new(name: params[:name]).valid?
end

def word_valid?(word)
  @word = Word.new(word: word)
  @word.validate
  Word.new(word: word).valid?
end

def redirect_root
  redirect "/"
end

# User class

class User < ActiveRecord::Base
  has_many :phrases
  validates :name, presence: true, length: 2..20, uniqueness: { case_sensitive: false }
end

# Word class

class Word < ActiveRecord::Base
  REGEX = /\A[[А-Яа-я]\w\,]+\z/i
  validates :word, presence: true, length: 1..15, format: { with: REGEX }
end

# Phrase class

class Phrase < ActiveRecord::Base
  belongs_to :user
  validates :phrase, presence: true, length: 1..255
end
