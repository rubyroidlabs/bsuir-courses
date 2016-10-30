module BotCommand
  # Class for /cancel command
  class Cancel < Base
    def should_start?
      text =~ %r{/cancel}
    end

    # If we are here, we have no action to cancel.
    # That's because actions are handled with higher
    # priorities, rather than commands
    def start
      send_message(Responses::NO_CANCEL)
    end
  end
end
