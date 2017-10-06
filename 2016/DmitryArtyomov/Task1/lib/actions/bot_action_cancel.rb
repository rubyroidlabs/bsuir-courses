module BotAction
  # Class for cancelling stored actions
  class Cancel < Base
    def should_start?
      text =~ %r{/cancel} && action?
    end

    def start
      action_handler.del_action(user, Responses::CANCEL)
    end
  end
end
