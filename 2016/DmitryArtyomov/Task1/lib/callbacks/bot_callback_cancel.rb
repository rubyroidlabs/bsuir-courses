module BotCallback
  # Class for cancelling stored callback
  class Cancel < Base
    def should_start?
      callback_data[0] =~ /cancel/
    end

    def start
      # If not a real callback, send additional message
      unless msg_id
        callback.message.message_id = user.callback_msg_id
        message_handler.send_message(user_id, Responses::CANCEL)
      end
      edit_inline_message(Responses::CANCEL)
      remove
    end
  end
end
