module BotCommand
  # Class for not existing command
  class Undefined < Base
    def should_start?
      true
    end

    def start
      send_message(Responses::NO_CMD)
      nil
    end
  end
end
