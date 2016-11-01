module Bot
  module Command
    # Base class for user commands
    class Base
      attr_reader :user, :text, :api

      def initialize(user, message)
        @user = user
        @text = message[:text]
        @api = Bot.configuration.api
      end

      def should_start?
        triggers = translate("triggers")
        triggers.include?(text) || triggers.empty?
      end

      def start
        fail(NotImplementedError)
      end

      def select_next_command
        user.reset_next_command
      end

      def self.command_name
        to_s.sub(/.*Command::/, "").downcase
      end

      protected

      def send_message(response_text, options = {})
        api.call(
          "sendMessage",
          chat_id: user.telegram_id,
          text: response_text,
          parse_mode: "markdown",
          reply_markup: options[:reply_markup]
        )
      end

      def class_name
        self.class.to_s
      end

      def command_scope
        "commands.#{self.class.command_name}"
      end

      def translate(name, options = {})
        lookup = "#{command_scope}.#{name}"
        I18n.t(lookup, options.merge(default: name.to_sym))
      end

      def response(name, options = {})
        lookup = "#{command_scope}.response.#{name}"
        I18n.t(lookup, options.merge(default: name.to_sym))
      end

      def error(name, options = {})
        lookup = "#{command_scope}.errors.#{name}"
        I18n.t(lookup, options.merge(default: "errors.#{name}"))
      end
    end
  end
end
