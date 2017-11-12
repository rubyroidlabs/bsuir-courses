module BotCommand
  # Class for starting import of subjects
  class Import < Base
    def should_start?
      text =~ %r{/import}
    end

    def start
      @action_handler.add_action(user, 'IMPORT_GROUP')
    end
  end
end
