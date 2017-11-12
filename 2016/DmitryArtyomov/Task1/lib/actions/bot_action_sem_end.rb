module BotAction
  # Class for handling input of semester end
  class SemEnd < Base
    def should_start?
      action[0] =~ /SEM_END/
    end

    def start
      backup = backup_sem
      if DateParser.valid_date?(text)
        user.sem_start = action[1]
        user.sem_end = DateParser.parse(text)
      else
        action_handler.repeat_action(user)
        return
      end
      check_sem(backup)
    end

    private

    def backup_sem
      [user.sem_start, user.sem_end]
    end

    def check_sem(backup)
      if user.sem_time_length <= 0
        user.sem_start = backup[0]
        user.sem_end = backup[1]
        action_handler.add_action(user, 'SEM_START')
      else
        action_handler.del_action(user, form_message)
      end
    end

    # Fuck ABC
    def form_message_prepare
      [
        user.sem_time_left / 30,
        user.sem_time_left % 30,
        user.sem_time_length / 30,
        user.sem_time_length % 30
      ]
    end

    def sem_now_text
      user.sem_now? ? Responses::SEM_OK_NOW : Responses::SEM_OK_NOT_NOW
    end

    def form_message
      prepared = form_message_prepare
      sem_now_text
        .sub('[ML]', prepared[0].to_s)
        .sub('[DL]', prepared[1].to_s)
        .sub('[MT]', prepared[2].to_s)
        .sub('[DT]', prepared[3].to_s)
    end
  end
end
