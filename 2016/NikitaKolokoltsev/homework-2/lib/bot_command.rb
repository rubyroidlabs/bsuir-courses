# Class for better structure representation
class BotCommand < Bot
  # Handling situation with no update. Can be disabled if using webhooks
  def update
    update = super
    update[0] ? update : [{ message: { text: "" } }]
  end
end
