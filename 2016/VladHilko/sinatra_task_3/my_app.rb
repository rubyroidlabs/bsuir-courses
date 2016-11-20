require "sinatra"
require "redis"
require "json"

configure do
  enable :sessions
end

set :redis, Redis.new
# for heroku 
# set :uri, URI.parse(ENV["REDISTOGO_URL"])
# set :redis, Redis.new(:host => settings.uri.host, :port => settings.uri.port, :password => settings.uri.password)

helpers do
  def username
    session[:identity] ? session[:identity] : ""
  end

  def show_word
    session[:word] ? session[:word] : "nothing"
  end

  def return_name_with_sentence(sentence)
    users_hash = settings.redis.get(sentence.to_s)
    return [] unless users_hash
    data = JSON.parse(users_hash)
    return_full_arr(data)
  end

  # def sorted_sentence
  #   return_array_sentence.sort_by { |b| b.delete("sentence_").to_i }
  # end

  def return_all_words(sentence)
    users_hash = settings.redis.get(sentence.to_s)
    return "" unless users_hash
    data = JSON.parse(users_hash)
    data.values.map { |a| a["word"] }.join(" ")
  end

  def return_array_sentence
    @sentence_arr = []
    settings.redis.keys("*").select { |a| a.include?("sentence_") }.sort_by { |b| b.delete("sentence_").to_i }.each do |list_name|
      @sentence_arr << return_all_words(list_name)
    end
    @sentence_arr
  end
end

# methods begin
def return_full_arr(data)
  full_arr = []
  @data_values = data.values
  data.size.times do |i|
    my_sentence = @data_values[0..i].map { |a| a["word"] }
    last_word = my_sentence.pop
    full_arr << [@data_values[i]["name"], my_sentence.join(" "), last_word, @data_values[i]["time"]]
  end
  full_arr
end

def add_word_to_hash(sentence_id)
  @redis = settings.redis
  if @redis.get("sentence_#{sentence_id}").nil?
    @redis.set("word_count_#{sentence_id}", 1)
    @local_hash = {}
  end

  return unless available_sentence?(sentence_id)
  add_hash_to_redis(sentence_id)
end

def add_hash_to_redis(sentence_id)
  @redis = settings.redis
  inner_hash = { "name" => username, "word" => show_word, "time" => Time.now.strftime("%a, %d %b %Y %H:%M:%S") }
  @local_hash ||= JSON.parse(@redis.get("sentence_#{sentence_id}"))
  @local_hash[@redis.get("word_count_#{sentence_id}")] = inner_hash

  @redis.set("sentence_#{sentence_id}", @local_hash.to_json)
  @redis.incr("word_count_#{sentence_id}")
end

def available_sentence?(sentence_id)
  @redis_value = settings.redis.get("sentence_#{sentence_id}")
  return true if @redis_value.nil?
  @hash = JSON.parse(@redis_value)

  @last_name = @hash[@hash.size.to_s]["name"]
  @last_name != username
end

def available_word?(word)
  word.split.size <= 1 && word.size >= 1
end
# ends methods

before "/add/*" do
  unless session[:identity]
    session[:previous_url] = request.path
    @error = "Sorry, you need to be logged in to visit " + request.path
    halt erb(:login_form)
  end
end

# before "/word/attempt/*" do
#   unless session[:identity]
#     session[:previous_url] = request.path
#     @error = "Sorry, you need to be logged in to visit " + request.path
#     halt erb(:login_form)
#   end
# end

get "/login/form" do
  erb :login_form
end

get "/add/word" do
  settings.redis.incr("count_sentence")
  @sentence_id_my = settings.redis.get("count_sentence")
  erb :add_word_form
end

get "/add/word/:id" do
  @sentence_id_my = params[:id]
  erb :add_word_form
end

get "/logout" do
  session.delete(:identity)
  session.delete(:previous_url)
  erb "<div class='alert alert-message'>Logged out</div>"
  redirect to "/"
end

get "/" do
  erb :test
end

get "/mistake" do
  @error = "Sorry, you can't add word to this sentence "
  erb :main_mistake
end

post "/login/attempt" do
  session[:identity] = params["username"]
  where_user_came_from = session[:previous_url] || "/"
  redirect to where_user_came_from
end

post "/word/attempt/:id" do
  session[:word] = params["word"]
  unless available_word?(show_word)
    @error = "Sorry, you need to be write only one word "
    @sentence_id_my = params[:id]
    halt erb(:add_word_form)
  end
  @sentence_id = params[:id]
  add_word_to_hash(@sentence_id)
  redirect to "/"
end
