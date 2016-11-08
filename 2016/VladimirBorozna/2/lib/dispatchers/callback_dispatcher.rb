module Bot
  # Class for dispatching user commands
  class CallbackDispatcher
    attr_reader :query,
                :user,
                :api

    AVAILABLE_CALLBACKS = [
      Callback::SubjectName,
      Callback::WorkNumber,
      Callback::Cancel
    ].freeze

    def initialize(user, query)
      @query = query
      @user = user
      @api = Bot.configuration.api
    end

    def dispatch
      callback = AVAILABLE_CALLBACKS.detect do |callback_class|
        callback_class.new(user, query).should_start?
      end
      callback&.new(user, query).start
    rescue BotError => error
      handle_error(error)
    end

    private

    def handle_error(error)
      error_message = I18n.t("errors.#{error.message}")
      api.call(
        "editMessageText",
        chat_id:      user.telegram_id,
        message_id:   query.message.message_id,
        text:         error_message,
        parse_mode:   "markdown"
      )
    end
  end
end
