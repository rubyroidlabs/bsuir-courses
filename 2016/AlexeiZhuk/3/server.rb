require "sinatra"
require "json"
require "redis"
require "byebug"
require_relative "./lib/redis.rb"

use Rack::Session::Cookie, "key" => "session",
                           "secret" => "some_secret"

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
  if session[:username] == data["phrase"][@id]["id_user"]
    erb "<div class='alert alert-message'>Wait, please</div>"
  else
    @hash = data["phrase"]
    erb :edit
  end
end

post "/edit" do
  @id = params["id"]
  @hash = data["phrase"][@id]["text"]
  @hash += " "
  @hash += "#{ params['new_word'] }"
  data["phrase"][@id]["text"] = @hash
  data["phrase"][@id]["id_user"] = session[:username]
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
  add_phrase(params["phrase"])
  redirect to "/"
end

def add_phrase(value)
  data = Database.get_db("db")
  @hash = data["phrase"]
  history_hash = create_history(session[:username], value)
  if @hash.nil?
    @hash = { "0" => { "text" => value,  "id_user" => session[:username], "history" => { 1 => history_hash } } }
  else
    @hash[@hash.count] = { "text" => value,  "id_user" => session[:username], "history" => { 1 => history_hash } }
  end
  Database.set("db", "phrase" => @hash)
end

def create_history(id_user, word)
  time = Date.today
  current_time = time.to_s
  { "id_user" => id_user, "text" => word, "time" => current_time }
end
