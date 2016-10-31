require 'telegram/bot'
require 'webrick'
require 'json'
require 'redis'
require_relative 'servlet'

TOKEN = '269397188:AAEAg1R3nq1eJ7eaEwCv64oKAo2qXsi0h0g'
 
 # https://api.telegram.org/bot269397188:AAEAg1R3nq1eJ7eaEwCv64oKAo2qXsi0h0g/setWebhook?url=https://25f68bd2.ngrok.io/webhooks/telegram_Xi39zZtru6W3Eop89Ocz
 # lsof -wni tcp:8080
 # kill -9 <pid>
 

class Bot
  def initialize
    @token = TOKEN
  end

  def start
    Telegram::Bot::Client.run(@token) { |bot| @bot = bot }
    server = WEBrick::HTTPServer.new(:Port => 8080)
    server.mount("/", MyServlet, @bot)
    trap("INT") { server.shutdown } 
    server.start
  end
end
 
 
