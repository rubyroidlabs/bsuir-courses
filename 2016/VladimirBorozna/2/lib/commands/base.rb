module Bot
  module Command
    # Base class of user-based commands
    class Base
      include Bot::TranslationHelpers

      attr_reader :api,
                  :user,
                  :message,
                  :next_command

      def initialize(api, user, message)
        @api          = api
        @user         = user
        @message      = message
        @next_command = user.next_command
      end

      def should_start?
        lookup = "#{command_scope}.#{class_name}.triggers"
        triggers = translate(lookup)
        triggers.include?(text) || triggers.empty?
      end

      def start
        fail(NotImplementedError)
      end

      def set_next_method
        return unless methods_defined?

        if last_method?
          next_command.reset
        else
          next_command.set(command_class.to_s, methods[next_method_index])
        end
      end

      protected

      def text
        @text ||= message.text
      end

      def send_message(text, options = {})
        options[:chat_id] = user.telegram_id
        options[:text] = text
        api.call("sendMessage", options)
      end

      private

      def methods_defined?
        command_class.const_defined?(:AVAILABLE_METHODS)
      end

      def last_method?
        methods.size - 1 == method_index
      end

      def next_method_index
        method_index.nil? ? 0 : method_index + 1
      end

      def method_index
        @method_index ||= methods.index(next_command.method)
      end

      def methods
        @methods ||= command_class::AVAILABLE_METHODS
      end

      def command_class
        @command_class ||= self.class
      end
    end
  end
end
