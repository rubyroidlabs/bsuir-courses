module Bot
  module Callback
    # Base class for callbacks
    class Base
      include Bot::TranslationHelpers
      DATA_DELIMITER = ";".freeze

      attr_reader :user,
                  :api,
                  :data,
                  :message

      def initialize(api, user, query)
        @data    = query.data.split(DATA_DELIMITER)
        @message = query.message
        @user    = user
        @api     = api
      end

      def should_start?
        fail(NotImplementedError)
      end

      def start
        fail(NotImplementedError)
      end

      protected

      def edit_message(text, options = {})
        options[:chat_id] = user.telegram_id
        options[:message_id] = message.message_id
        options[:text] = text
        api.call("editMessageText", options)
      end
    end
  end
end
