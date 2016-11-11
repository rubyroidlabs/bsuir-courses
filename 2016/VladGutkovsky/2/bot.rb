require 'telegram/bot'

require_relative 'session'
require_relative 'handlers'
require_relative 'utils'

Message = Telegram::Bot::Types::Message
Client = Telegram::Bot::Client

Session.clear

Client.run('TOKEN') do |bot|
  handlers = [
    Reset.new,
    Start.new,
    Status.new,
    Semester.new,
    Subject.new,
    ClearAll.new
  ]
  bot.listen do |message|
    Session.id = message.chat.id
    Session.request = message.text
    handler = handlers.detect { |h| h == Session.request }
    unless handler.nil?
      begin
        Utils.handle_message bot.api, handler, message
      rescue => e
        p e
        puts e.backtrace
        Utils.something_wrong bot.api
      end
    end
  end
end
