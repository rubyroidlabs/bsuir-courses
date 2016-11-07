# Class for dispatching all actions
class ActionDispatcher
  AVAILABLE_ACTIONS = [
    BotAction::Cancel,
    BotAction::SemStart,
    BotAction::SemEnd,
    BotAction::ImportGroup,
    BotAction::SubjName
  ].freeze

  def initialize(message, message_handler, action_handler)
    @message = message
    @message_handler = message_handler
    @action_handler = action_handler
    dispatch
  end

  private

  attr_reader :message, :message_handler, :action_handler

  def dispatch
    action = AVAILABLE_ACTIONS.find do |act|
      act.new(message, message_handler, action_handler).should_start?
    end
    action.new(message, message_handler, action_handler).start if action
    !action.nil?
  end
end
