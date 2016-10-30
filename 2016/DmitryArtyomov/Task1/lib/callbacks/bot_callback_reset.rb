module BotCallback
  # Class for resetting all user data from a corresponding callback
  class Reset < Base
    def should_start?
      callback_data[0] =~ /reset/
    end

    def start
      user.delete
      text = Responses::RESET_OK
      edit_inline_message(text)
    end
  end
end
