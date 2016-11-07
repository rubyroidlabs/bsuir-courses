require "telegram/bot"
require "webrick"
require "json"
require "redis"
require_relative "servlet"

TOKEN = "289410618:AAGCYzweaG-rTtTR15mvamdJ_yFxACmJMLU".freeze

# https://api.telegram.org/bot289410618:AAGCYzweaG-rTtTR15mvamdJ_yFxACmJMLU/setWebhook?url=https://d5ec8f12.ngrok.io/webhooks/telegram_Xi39zZFru6J3oop897cz

# Here we are creating HTTPServer.
class Bot
  def initialize
    @token = TOKEN
  end

  def start
    Telegram::Bot::Client.run(@token) { |bot| @bot = bot }
    server = WEBrick::HTTPServer.new(Port: 8080)
    server.mount("/", MyServlet, @bot)
    trap("INT") { server.shutdown }
    server.start
  end
end
