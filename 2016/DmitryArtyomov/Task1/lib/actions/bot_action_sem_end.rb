module BotAction
  # Class for handling end of input for semester
  class SemEnd < Base
    def should_start?
      action[0] =~ /SEM_END/
    end

    def start
      if DateParser.valid_date?(text)
        user.sem_start = action[1]
        user.sem_end = DateParser.parse(text)
      else
        action_handler.repeat_action(user)
        return
      end
      check_sem
    end

    private

    def check_sem
      if user.sem_time_length <= 0
        action_handler.add_action(user, 'SEM_START')
      else
        action_handler.del_action(user, form_message)
      end
    end

    def form_message
      Responses::SEM_OK
        .sub('[M]', (user.sem_time_length / 30).to_s)
        .sub('[D]', (user.sem_time_length % 30).to_s)
    end
  end
end
