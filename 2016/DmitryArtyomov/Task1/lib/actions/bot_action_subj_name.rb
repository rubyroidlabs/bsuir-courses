module BotAction
  # Class for handling input of subject name
  class SubjName < Base
    def should_start?
      user.action[0] =~ /SUBJ_NAME/
    end

    def start
      if !valid_string(text)
        action_handler.repeat_action(user)
      elsif user.subject?(text)
        action_handler.del_action(user, Responses::SUBJ_EXIST)
      else
        action_handler.add_action(user, 'SUBJ_COUNT', text)
      end
    end

    private

    def valid_string(text)
      !(text.empty? || text.include?('/'))
    end
  end
end
