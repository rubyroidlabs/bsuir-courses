require 'sinatra'
require 'redis'
require 'json'
require './lib/requests_methods.rb'
configure do
  $redis = Redis.new(host: "127.0.0.1", port: 6379)
  include RequestsMethods
use Rack::Session::Cookie, "key" => "session",
                           "expire_after" => Time.now.to_i + 2_592_000,
                           "secret" => "bla-bla-bla"
  $word = ''
  $delay_now = Time.now
end
#find all methods for requests in /lib/requests_methods.rb
get '/registrate' do
  erb :registrate
end
get '/' do 
  @output = output_all_phrases($redis)
  @output_name = "#{session[:user_name]}"
  erb :main
end
post '/registrate' do
  session[:user_name] = params.fetch("nick_name")        
  redirect "../"
end
get '/new_phrase' do
  erb :new_phrase
end
post '/new_phrase' do
  add_new_phrase($redis, $word)
  redirect "../"
end
get '/phrases/:word' do
  $word = params[:word].to_s
  erb :redact_phrase
end
post '/phrases/:word' do
  $word = params.fetch("word")
  $delay_now = make_timer
  redact_phrase($redis, $word, @last_redact)
  session[params[:word].to_sym] = session[:user_name]
  redirect "../"
end
get '/logout' do
  session.delete(:user_name)
  redirect "../"
end
