module Bot
  # Class for dispatching user commands
  class CallbackDispatcher < Dispatcher
    attr_reader :query

    AVAILABLE_CALLBACKS = [
      Callback::Cancel,
      Callback::NotificationSetting,
      Callback::SubjectName,
      Callback::WorkNumber
    ].freeze

    def initialize(api, user, query)
      super(api, user)
      @query = query
    end

    def dispatch
      process
    rescue BotError => e
      handle_error(e)
    end

    private

    def process
      callback = AVAILABLE_CALLBACKS.detect do |callback_class|
        callback_class.new(api, user, query).should_start?
      end
      callback&.new(api, user, query).start
    end

    def handle_error(error)
      api.call(
        "editMessageText",
        chat_id:      user.telegram_id,
        message_id:   query.message.message_id,
        text:         translate_error(error.message)
      )
    end
  end
end
