require 'telegram/bot'
require "webrick"
require "json"
# require "redis"
require_relative 'servlet'
 
 
 
 
 
TOKEN = '269397188:AAEAg1R3nq1eJ7eaEwCv64oKAo2qXsi0h0g'
 
Telegram::Bot::Client.run(TOKEN) do |bot|
  $bot = bot
end
 
 
server = WEBrick::HTTPServer.new(:Port => 8080)
 
server.mount "/", MyServlet
 
trap("INT") {
    server.shutdown
}
 
server.start