module BotCommand
  # Class for /semester command
  class Semester < Base
    def should_start?
      text =~ %r{/semester}
    end

    def start
      @action_handler.add_action(user, 'SEM_START')
    end
  end
end
