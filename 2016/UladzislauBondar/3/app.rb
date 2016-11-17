require "sinatra"
require "slim"

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

get "/" do
  @phrases = Phrase.all
  slim :home
end