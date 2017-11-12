module BotCommand
  # Class for /cancel command
  class Cancel < Base
    def should_start?
      text =~ %r{/cancel}
    end

    def start
      if user.callback?
        # Emulate cancel callback for callback handler
        callback = create_cancel_callback
        CallbackDispatcher.new(callback, message_handler)
      else
        # If we are here, we have nothing to cancel.
        # That's because actions are handled with higher
        # priorities, rather than commands
        send_message(Responses::NO_CANCEL)
      end
    end

    private

    def create_cancel_callback
      Telegram::Bot::Types::CallbackQuery.new(
        from: message.from,
        message: Telegram::Bot::Types::Message.new(
          chat: message.chat
        ),
        data: 'cancel'
      )
    end
  end
end
