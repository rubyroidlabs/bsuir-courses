module Bot
  module Command
    # Base class of user-based commands
    class Base
      include Bot::Translation

      attr_reader :user, :message, :api, :next_command

      def initialize(user, message)
        @user = user
        @next_command = user.next_command
        @message = message
        @api = Bot.configuration.api
      end

      def should_start?
        triggers = translate("triggers")
        triggers.include?(text) || triggers.empty?
      end

      def start
        fail NotImplementedError
      end

      def select_next_command
        user.next_command.reset
      end

      def text
        @text ||= message.text
      end

      protected

      def send_message(response_text, options = {})
        api.call(
          "sendMessage",
          chat_id:      user.telegram_id,
          text:         response_text,
          reply_markup: options[:reply_markup],
          parse_mode:   "markdown"
        )
      end

      def class_name
        self.class.to_s
      end
    end
  end
end
