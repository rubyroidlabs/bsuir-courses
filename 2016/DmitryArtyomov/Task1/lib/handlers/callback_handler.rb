# Class for handling stored callbacks
class CallbackHandler
  attr_reader :message_handler

  def initialize(message_handler)
    @message_handler = message_handler
  end

  def handle(callback)
    return unless User.new(callback.from.id).callback?
    CallbackDispatcher.new(callback, message_handler)
  end
end
