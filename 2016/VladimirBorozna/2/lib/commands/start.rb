module Bot
  module Command
    # Class for the command - /start
    class Start < Base
      def start
        send_message(response_message)
      end

      private

      def response_message
        commands.inject(response("greeting") << "\n") do |result, command|
          result << command_triggers(command)
          result << " - #{command_desciption(command)}\n"
        end
      end

      def commands
        Bot::CommandDispatcher::AVAILABLE_COMMANDS.map(&:command_name)
      end

      def command_triggers(command)
        lookup = "commands.#{command}.triggers"
        translate(lookup.to_sym).map { |t| "*#{t}*" }.join(", ")
      end

      def command_desciption(command)
        translate("commands.#{command}.description".to_sym)
      end
    end
  end
end
