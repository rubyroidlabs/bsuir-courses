module Bot
  module Command
    # Class for the command - /start
    class Start < Base
      DESCRIBED_COMMANDS = [
        Command::Start,
        Command::Semester,
        Command::Subject,
        Command::Submit,
        Command::Status,
        Command::Reset
      ].freeze

      def start
        send_message(response_message)
      end

      private

      def response_message
        commands.inject(command_response("greeting") << "\n") do |result, command|
          result << command_triggers(command)
          result << " - #{command_desciption(command)}\n"
        end
      end

      def commands
        DESCRIBED_COMMANDS.map do |command_class|
          command_class.to_s.sub(/.*Command::/, "").downcase
        end
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
