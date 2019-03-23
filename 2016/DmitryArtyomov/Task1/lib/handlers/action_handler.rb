# Class for handling stored actions
class ActionHandler
  attr_reader :message_handler

  def initialize(message_handler)
    @message_handler = message_handler
  end

  def handle(message)
    return unless User.new(message.chat.id).action?
    ActionDispatcher.new(message, message_handler, self)
  end

  def add_action(user, action, *args)
    return if action.nil?
    message_handler.send_message(user.user_id, Responses.const_get(action))
    user.set_action(action, *args)
  end

  def repeat_action(user)
    return unless user.action?
    add_action(user, user.action[0], *user.action.drop(1))
  end

  def del_action(user, succ_msg = nil)
    message_handler.send_message(user.user_id, succ_msg) unless succ_msg.nil?
    user.set_action(nil)
  end
end
