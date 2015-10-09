require 'sinatra'
require_relative '../game/life'
set :port, 5557
@life = Life.new
enable :sessions

get '/' do
  erb :index
end

get '/table' do
  @life = session[:life]
  @temp = session[:temp_life]

  @temp.do_iteration

  session[:life] = @temp
  session[:temp_life] = @temp

  erb :table
end

get '/input_life' do
  @sizes = session[:sizes]
  erb :input_life
end

post '/add' do
  if params[:sub] == 'Add randomly'
    @life = Life.new(params[:size]['x'].to_i, params[:size]['y'].to_i)
    session[:life] = @life
    session[:temp_life] = @life
    redirect to('/table')
  end

  if params[:sub] == 'Add manually'
    session[:sizes] = [params[:size]['x'].to_i, params[:size]['y'].to_i]
    redirect to('/input_life')
  end

  if params[:adding] == 'Add'
    x, y = session[:sizes]
    i = -1
    m = Array.new(x) do
      Array.new(y).map! do
        i += 1
        params[:size][i].to_i
      end
    end
    i = -1
    m1 = Array.new(x) do
      Array.new(y).map! do
        i += 1
        params[:size][i].to_i
      end
    end
    @life = Life.new(x, y)
    @temp = Life.new(x, y)
    @life.matrix = m
    @temp.matrix = m1
    session[:life] = @life
    session[:temp_life] = @temp
    redirect to('/table')
  end
end
