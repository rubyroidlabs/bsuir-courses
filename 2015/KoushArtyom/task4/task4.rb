require 'sinatra'

Tilt.register Tilt::ERBTemplate, 'html.erb'

get '/hi' do
  @array = Array.new(10) do
    Array.new(10) { rand(0..1) }
  end
  erb :hi
end
