require 'sinatra'

Tilt.register Tilt::ERBTemplate, 'html.erb'

get '/hi' do
  @array = Array.new(10) do |i|
    i = Array.new(10) { |a| a = rand(0..1) }
  end
  erb :hi
end
