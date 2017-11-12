module Bot
  module Callback
    # Callback that cancels current operation
    class Cancel < Base # :nodoc:
      def should_start?
        data.first =~ /cancel/
      end

      def start
        edit_message(callback_response("confirmation"))
      end
    end
  end
end
