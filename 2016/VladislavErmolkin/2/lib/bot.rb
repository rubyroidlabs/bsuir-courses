require 'telegram/bot'
require 'webrick'
require 'json'
require 'redis'
require_relative 'servlet'

TOKEN = '269397188:AAHQy3DIpZcQtT_sRLc2ADy2SgLhfGBmqZk'
 
 # https://api.telegram.org/bot269397188:AAHQy3DIpZcQtT_sRLc2ADy2SgLhfGBmqZk/setWebhook?url=https://b978b6b9.ngrok.io/webhooks/telegram_Xi39zZtru6V3oop897cz
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
    trap("INT") do
      server.shutdown
      p 'end!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    end
    server.start
  end
end
 
 
