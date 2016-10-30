module BotCallback
  # Class for cancelling stored callback
  class Cancel < Base
    def should_start?
      callback_data[0] =~ /cancel/
    end

    def start
      user.callback = nil
      edit_inline_message(Responses::CANCEL)
    end
  end
end
