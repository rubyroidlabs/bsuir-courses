module Bot
  # Class is used for handling raw user data
  class DateParser
    MIN_YEAR = 2016
    MAX_YEAR = 3000
    YEAR_RANGE = (MIN_YEAR..MAX_YEAR)

    class << self
      def parse(text)
        prepared_text = preprocessing(text)
        date = Date.strptime(prepared_text, "%d.%m.%Y")
        validate_date(date)
      rescue ArgumentError
        raise(BotError, "date_format_invalid")
      end

      private

      def validate_date(date)
        year = date.strftime("%Y").to_i
        fail(BotError, "date_year_invalid") unless YEAR_RANGE.cover?(year)
        date
      end

      def preprocessing(text)
        parts = text.tr("-", ".").split(".")
        fail(BotError, "date_year_invalid") unless parts.size == 3
        parts = parts.reverse if parts.first.length == 4

        format("%02d.%02d.%04d", *parts.map(&:to_i))
      end
    end
  end
end
