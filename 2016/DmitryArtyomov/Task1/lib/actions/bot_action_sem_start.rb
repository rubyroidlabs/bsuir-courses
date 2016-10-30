module BotAction
  # Class for handling start of input for semester
  class SemStart < Base
    def should_start?
      action[0] =~ /SEM_START/
    end

    def start
      if DateParser.valid_date?(text)
        sem_start = DateParser.parse(text)
        action_handler.add_action(user, 'SEM_END', sem_start)
      else
        action_handler.repeat_action(user)
      end
    end
  end
end
