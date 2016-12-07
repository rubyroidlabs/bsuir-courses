require "sinatra"
require "json"
require "redis"
require "byebug"
require_relative "./lib/redis.rb"

use Rack::Session::Cookie, "key" => "session",
                           "secret" => "some_secret"

def add_phrase(value, data)
  @hash = data["phrase"]
  history_hash = create_history(session[:username], value)
  if @hash.nil?
    @hash = { "0" => { "text" => value, "id_user_last" => session[:username], "history" => { 1 => history_hash } } }
  else
    @hash[@hash.count] = { "text" => value, "id_user" => session[:username], "history" => { 1 => history_hash } }
  end
  Database.set("db", "phrase" => @hash)
end

def create_history(id_user, word)
  date = Date.today
  time = date.to_s
  { "id_user" => id_user, "word" => word, "time" => time }
end

data = Database.get_db("db")

get "/" do
  @hash = data["phrase"]
  if @hash.nil?
    erb :no_phrase
  else
    erb :index
  end
end

get "/login" do
  erb :login
end

get "/create" do
  redirect to "/login" if session[:username].nil?
  erb :create
end

get "/logout" do
  session.delete(:username)
  redirect to "/"
end

get "/edit" do
  @id = params["id"]
  redirect to "/login" if session[:username].nil?
  if session[:username] == data["phrase"][@id]["id_user_last"]
    erb "<div class='alert alert-message'>You can not add anything!<br>Please, wait.</div>"
  else
    @hash = data["phrase"]
    erb :edit
  end
end

post "/edit" do
  @id = params["id"]
  @hash = data["phrase"][@id]["text"]
  word = params["new_word"]
  @hash += " #{word}"
  data["phrase"][@id]["text"] = @hash
  data["phrase"][@id]["id_user_last"] = session[:username]
  @count = data["phrase"][@id]["history"].count + 1
  data["phrase"][@id]["history"][@count] = create_history(session[:username], params["new_word"])
  Database.set("db", "phrase" => data["phrase"])
  redirect to "/"
end

post "/login" do
  redirect "/login" if params["username"].empty?
  session[:username] = params["username"]
  redirect to "/"
end

post "/new_create" do
  data = Database.get_db("db")
  add_phrase(params["phrase"], data)
  redirect to "/"
end
