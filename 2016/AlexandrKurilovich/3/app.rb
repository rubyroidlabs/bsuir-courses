require "json"
require "redis"

REDIS_HOST = { host: "redis-18148.c10.us-east-1-3.ec2.cloud.redislabs.com",
               port: "18148",
               password: "111111111111" }.dup.freeze

redis = Redis.new(REDIS_HOST)

enable :sessions

get '/' do
  session["user"] ||= nil
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
