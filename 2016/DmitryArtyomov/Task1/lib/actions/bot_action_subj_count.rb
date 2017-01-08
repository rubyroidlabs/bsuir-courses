module BotAction
  # Class for handling input of lab number per subject
  class SubjCount < Base
    def should_start?
      action[0] =~ /SUBJ_COUNT/
    end

    def start
      if valid_num?
        add_subject
      else
        action_handler.add_action(user, action[0], action[1])
      end
    end

    private

    def add_subject
      user.add_subject(action[1], text.to_i)
      action_handler.del_action(user, Responses::SUBJ_OK)
    end

    def valid_num?
      (text =~ /^\d+$/) && (1..30).cover?(text.to_i)
    end
  end
end
