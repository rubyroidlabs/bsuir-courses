# /: description
# /game: show game field
# /new: form for new field
# /step: step and redirect to /game
# /seed: seed and redirect to /game

require 'sinatra'
require 'pry'
require 'nlife'
require 'slim'

enable :sessions
set :session_secret, '1234'

$GAMES = {}

get '/' do
  slim :index, layout: :layout
end

get '/new' do
  slim :new, layout: :layout
end

post '/new' do
  rows = params['rows'].to_i
  cols = params['cols'].to_i
  game = NLife::Game.new(rows, cols)
  $GAMES[session['session_id']] = game
  redirect to('/game')
end

get '/game' do
  slim :game, layout: :layout
end

post '/game/step' do
  @game.reset
  params['c'] = {} unless params['c']
  params['c'].each_pair do |row, cols|
    cols.each_key do |col|
      @game.state[col.to_i, row.to_i] = 1.0
    end
  end
  @game.step
  redirect to('/game')
end

get '/game/seed' do
  @game.seed
  redirect to('/game')
end

before %r{/game(/.*)?} do
  @game = $GAMES[session['session_id']]
  redirect to('/new') unless @game
end
