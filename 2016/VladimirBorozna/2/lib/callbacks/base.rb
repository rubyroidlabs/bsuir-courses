module Bot
  module Callback
    class Base # :nodoc:
      include Bot::Translation

      attr_reader :user,
                  :api,
                  :data,
                  :message

      def initialize(user, query)
        @data    = query.data.split(";")
        @message = query.message
        @user    = user
        @api     = Bot.configuration.api
      end

      def should_start?
        fail NotImplementedError
      end

      def start
        fail NotImplementedError
      end

      protected

      def verify_callback
        check = user.callback.message_id == message.message_id
        fail(BotError, "callback_invalid_message") unless check
      end

      def edit_message(edited_text, options = {})
        api.call(
          "editMessageText",
          chat_id:      user.telegram_id,
          message_id:   message.message_id,
          text:         edited_text,
          reply_markup: options[:reply_markup],
          parse_mode:   "markdown"
        )
      end
    end
  end
end
