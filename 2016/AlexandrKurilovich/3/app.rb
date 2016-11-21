require "json"
require "redis"
require "date"
require_relative "helpers/index"
require_relative "helpers/new"
require_relative "helpers/show"

REDIS_HOST = { host: "redis-18148.c10.us-east-1-3.ec2.cloud.redislabs.com",
               port: "18148",
               password: "111111111111" }.dup.freeze

redis = Redis.new(REDIS_HOST)
enable :sessions

get '/' do
  session["user"] ||= nil
  index_help = IndexHelp.new(redis, session)
  @phrases = index_help.phrases
  @success_update = session["flash"]
  session["flash"] = nil
  @user = session["user"]
  slim :index
end

get '/login' do
  slim :login
end

post '/login' do
  login_params = params[:login]
  session["user"] = login_params["name"]
  redirect to('/')
end

get '/exit' do
  session["user"] = nil
  redirect to('/')
end

get '/new' do
  redirect to('/') if session["user"].nil?
  slim :new
end

post '/new' do
  new_help = NewHelp.new(redis, session, params)
  if new_help.valid?
    @alert = "Может быть только 1 знак препинания. Нельзя использовать точки"
    slim :new
  else
    new_help.save
    redirect to('/')
  end
end

get '/show' do
  show_help = ShowHelp.new(redis, session, params)
  redirect to('/login') if session["user"].nil?
  @phrase_id = show_help.phrase_id
  redirect to('/') if show_help.valid_params?
  @phrase = show_help.phrase
  @phrase_info = show_help.get_info_show
  @user_last = show_help.user_last?
  @alert = "Может быть только 1 знак препинания. Нельзя использовать точки" if params[:fail] == "true"
  slim :show
end

post '/show' do
  show_help = ShowHelp.new(redis, session, params)
  if show_help.valid_word?
    redirect to("/show?id=#{@params[:word]["id"]}&fail=true")
  else
    show_help.save
    redirect to('/')
  end
end
