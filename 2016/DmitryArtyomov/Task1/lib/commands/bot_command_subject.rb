module BotCommand
  # Class for add subject command
  class Subject < Base
    def should_start?
      text =~ %r{/subject}
    end

    def start
      @action_handler.add_action(user, 'SUBJ_NAME')
    end
  end
end
