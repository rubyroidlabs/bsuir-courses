require 'sinatra'
require 'pry'
require_relative 'lib/gol'

get '/' do
  erb :index
end

post '/create' do
  @@game = GameOfLife.new(params[:rows].to_i, params[:columns].to_i)
  redirect to('/game/0')
end

get '/game/:state' do
  @@game.next_state unless params[:state] == 0
  erb :game, locals: { state: params[:state], game: @@game }
end
