module Bot
  # Class is used for handling raw user data
  class NumberParser
    MIN_NUMBER = 1
    MAX_NUMBER = 50
    NUMBER_RANGE = (MIN_NUMBER..MAX_NUMBER)

    class << self
      def parse(text)
        validate_date(text.to_i)
      rescue ArgumentError
        raise(BotError, "number_invalid")
      end

      private

      def validate_date(number)
        fail(BotError, "number_invalid") unless NUMBER_RANGE.cover?(number)
        number
      end
    end
  end
end
