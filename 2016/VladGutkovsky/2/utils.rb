require "telegram/bot"
require "faraday"

require_relative "session"
require_relative "dialog"

# common methods
module Utils
  def self.send_promt(api, answer)
    Session.set("__promt__", answer.var)
    api.send_message chat_id: Session.id, text: answer.message
  end

  def self.send_answer(api, answer)
    case answer
    when Promt then send_promt api, answer
    when String then api.send_message chat_id: Session.id, text: answer
    when Image then api.send_photo(
      chat_id: Session.id,
      photo: Faraday::UploadIO.new(answer.url, answer.mime)
    )
    end
  end

  def self.handle_message(api, handler, message)
    answer = handler.handle message.from, Session.request
    if answer.is_a? Array
      answer.each { |a| send_answer api, a }
    else
      send_answer api, answer
    end
  end

  def self.something_wrong(api)
    api.send_message(
      chat_id: Session.id,
      text: EXCEPTION_MESSAGE
    )
  end
end

# responce class for request value of variable
class Promt
  attr_reader :message, :var
  def initialize(message, var)
    @message = message
    @var = var
  end
end

# class for sending images
class Image
  attr_reader :url, :mime
  def initialize(url, mime)
    @url = url
    @mime = mime
  end
end
