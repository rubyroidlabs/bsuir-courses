module Bot
  module Command
    # Class for the command - /start
    class Start < Base
      def start
        send_message(response_message, parse_mode: "markdown")
      end

      private

      def response_message
        greeting = command_response("greeting") << "\n"
        commands.inject(greeting) do |result, command|
          result << "#{triggers(command)} - #{desciption(command)}\n"
        end
      end

      def commands
        Bot::CommandDispatcher::AVAILABLE_COMMANDS.map do |command_class|
          command_class.to_s.sub(%r{.*Command::}, "").downcase
        end
      end

      def triggers(command)
        lookup = "commands.#{command}.triggers"
        translate(lookup).map { |trigger| "*#{trigger}*" }.join(", ")
      end

      def desciption(command)
        translate("commands.#{command}.description")
      end
    end
  end
end
