module Bot
  module Command
    # Class for the command - /cancel
    class Cancel < Base
      def start
        user.next_command.reset
        send_message(command_response("confirmation"))
      end
    end
  end
end
