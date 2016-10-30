module BotCommand
  # Class for /start command
  class Start < Base
    def should_start?
      text =~ %r{/start}
    end

    def start
      send_message(Responses::START)
    end
  end
end
