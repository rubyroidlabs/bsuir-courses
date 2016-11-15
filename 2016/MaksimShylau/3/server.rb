require "rubygems"
require "sinatra"
require "json"
require "redis"
require_relative "./lib/db"

use Rack::Session::Cookie, "key" => "session",
                           "expire_after" => Time.now.to_i + 2592000,
                           "secret" => "bla-bla-bla"
db = Database.new

def history_in_hash(word_number, username, word, history)
  history = [] if history.nil?
  history[word_number] = {} if history[word_number].nil?
  history[word_number]["time"] = Time.now.to_i
  history[word_number]["created_by"] = username
  history[word_number]["value"] = word
  history
end

def phrase_in_hash_helper(count, phrase, hash, user)
  hash["phrases"] = [{}] if hash["phrases"].nil?
  hash["phrases"][count] = {}
  hash["phrases"][count]["word_count"] = 0 if hash["phrases"][count]["word_count"].nil?
  hash["phrases"][count]["word_count"] += 1
  hash["phrases"][count]["text"] = phrase
  hash["phrases"][count]["edited_by"] = user
  hash
end

def phrase_in_hash(phrase, hash, user)
  count = hash["count"]
  hash = phrase_in_hash_helper(count, phrase, hash, user)
  history = hash["phrases"][count]["history"] ? hash["phrases"][count]["history"] : []
  hash["phrases"][count]["history"] = history_in_hash(0, user, phrase, history)
  hash["count"] += 1
  hash
end

def last_added_phrase(hash, user)
  hash[user] = {} if hash[user].nil?
  hash[user]["last_phrase_time"] = Time.now.to_i
  hash
end

def no_spam(time)
  Time.now.to_i < time.to_i + 30 ? true : false
end

def redirect_if_spam(user_hash, user)
  unless user_hash[user].nil?
    unless user_hash[user]["last_phrase_time"].nil?
      old_time = user_hash[user]["last_phrase_time"]
      redirect "/new_phrase?error=too_many_phrases" if no_spam(old_time)
    end
  end
end

def username
  session[:username] ? session[:username] : "Hello stranger"
end

def get_regex(phrase)
  regex = /([a-zA-Z]+|[а-яА-Яё])+,?;?:?-?/.match(phrase)
  regex
end

def edit_set_hash(hash, id, phrase, user, regex)
  hash["phrases"][id]["text"] = phrase
  hash["phrases"][id]["edited_by"] = user
  hash["phrases"][id]["history"] = history_in_hash(hash["phrases"][id]["word_count"], user, regex, hash["phrases"][id]["history"])
  hash["phrases"][id]["word_count"] += 1
  hash
end

get "/" do
  @hash = db.get_hash
  @phrases = @hash["phrases"]
  @count = @hash["count"]
  @user = session[:username]
  if @count.zero?
    erb "<div class='alert alert-message'>There are no any phrases yet! You can <a href='/new_phrase'>add it</a>!</div>"
  else
    session[:previous_url] = "/"
    erb :index
  end
end

get "/login" do
  if !session[:username].nil? 
    erb "<div class='alert alert-message'>You've already been authorized, #{session[:username]}!</div>"
  else
    erb :login
  end
end

get "/logout" do
  session.delete(:username)
  erb "<div class='alert alert-message'>You've been logged out</div>"
end

get "/new_phrase" do
  session[:previous_url] = "/new_phrase"
  redirect "/login" if session[:username].nil?
  @bool = (params["error"] == "too_many_phrases")
  erb :new_phrase
end

post "/new_phrase" do
  user_hash = db.get_user_hash
  redirect_if_spam(user_hash, session[:username])
  regex = get_regex(params["phrase"])
  last_added_phrase(user_hash, session[:username])
  redirect "/new_phrase?phrase=#{params['phrase']}" if params["phrase"].empty? || regex.nil?
  @phrase_text = regex
  hash = phrase_in_hash(@phrase_text, db.get_hash, session[:username])
  db.set_hash(hash)
  db.set_user_hash(user_hash)
  erb :new_phrase_added
end

get "/delete_all" do
  hash = { "count" => 0 }
  db.set_hash(hash)
  redirect "/"
end

get "/edit" do
  hash = db.get_hash
  redirect "/" if params["id"].nil? || params["id"].to_i.negative? || params["id"].to_i > hash["count"].to_i - 1
  session[:previous_url] = "/edit?id=" + params["id"]
  redirect "/login" if session[:username].nil?
  @id = params["id"].to_i
  redirect "/" if hash["phrases"][@id]["edited_by"] == session[:username]
  @phrase = hash["phrases"][@id]["text"]
  @history = hash["phrases"][params["id"].to_i]["history"]
  erb :edit
end

post "/edit" do
  hash = db.get_hash
  phrase_to_join = params["phrase"]
  @phrase = hash["phrases"][params["id"].to_i]["text"]
  regex = get_regex(phrase_to_join)
  redirect "/edit?id=#{params[:id]}&phrase=#{phrase_to_join}" if params["phrase"].empty? || regex.nil?
  @phrase = [@phrase, regex.to_s].reject(&:empty?).join(" ")
  hash = edit_set_hash(hash, params["id"].to_i, @phrase, session[:username], regex.to_s)
  db.set_hash(hash)
  erb :edited
end

post "/login" do
  redirect "/login" if params["username"].empty?
  session[:username] = params["username"]
  where_user_came_from = session[:previous_url] || "/"
  redirect to where_user_came_from
end

not_found do
  status 404
  erb :oops
end
