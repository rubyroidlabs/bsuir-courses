require 'webrick'
require_relative 'bot.rb'

server = WEBrick::HTTPServer.new(
  Port: ENV['PORT'],
  AccessLog: []
)
server.mount '/' + Secret::TELEGRAM_TOKEN, Bot

trap 'TERM' do
  server.shutdown
end

server.start
