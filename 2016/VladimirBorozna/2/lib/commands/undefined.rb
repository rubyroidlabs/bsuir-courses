module Bot
  module Command
    # Class for the undefined command
    class Undefined < Base
      def start
        send_message(response("dont_understand"))
      end
    end
  end
end
