require "telegram/bot"

require_relative "session"
require_relative "handlers"
require_relative "utils"

CallbackQuery = Telegram::Bot::Types::CallbackQuery
Message = Telegram::Bot::Types::Message
Client = Telegram::Bot::Client

def start_reminder_loop(api)
  Thread.new do
    loop do
      # sleep 1.days
      # Session.get_absolute
      #        .map { |key| key.split(":")[0] }
      #        .uniq
      #        .each { |id| api.send_message chat_id: id.to_i, text: "hello" }
      sleep 3
      puts "remind", api
    end
  end
end

def setup_handlers
  [
    Reset.new,    Start.new,   Status.new,
    Semester.new, Subject.new, Submit.new,
    Submit::QueryHandler.new
  ]
end

Client.run("__CUT__") do |bot|
  start_reminder_loop bot.api
  handlers = setup_handlers
  bot.listen do |message|
    case message
    when Message
      Session.id = message.chat.id
      Session.request = message.text
    when CallbackQuery
      Session.id = message.from.id
      Session.request = message.data
    end
    handler = handlers.find { |h| h == Session.request }
    unless handler.nil?
      begin
        case message
        when Message then Utils.handle_message bot.api, handler, message
        when CallbackQuery then Utils.handle_query bot.api, handler, message
        end
      rescue
        Utils.something_wrong bot.api
      end
    end
  end
end
