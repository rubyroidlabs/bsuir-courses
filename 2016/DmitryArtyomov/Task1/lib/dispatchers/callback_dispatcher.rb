# Class for dispatching all callbacks
class CallbackDispatcher
  AVAILABLE_CALLBACKS = [
    BotCallback::Cancel,
    BotCallback::RemindAddStart,
    BotCallback::RemindAddDay,
    BotCallback::RemindAddTime,
    BotCallback::RemindDeleteChoose,
    BotCallback::RemindDeleteEnd,
    BotCallback::ImportStop,
    BotCallback::ImportSubject,
    BotCallback::ImportLabs,
    BotCallback::SubjectAdd,
    BotCallback::SubjectDelete,
    BotCallback::SubmitName,
    BotCallback::SubmitLab,
    BotCallback::Reset
  ].freeze

  def initialize(callback, message_handler)
    @callback = callback
    @message_handler = message_handler
    dispatch
  end

  private

  attr_reader :callback, :message_handler

  def dispatch
    cback = AVAILABLE_CALLBACKS.find do |cb|
      cb.new(callback, message_handler).should_start?
    end
    cback.new(callback, message_handler).start if cback
    !cback.nil?
  end
end
