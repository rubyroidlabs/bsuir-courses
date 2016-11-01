module Bot
  # Class is used for handling raw user data
  class Parser
    MAX_NUMBER_OF_WORKS = 30
    MAX_SUBJECT_NAME_LENGTH = 20

    class << self
      def parse_date(text)
        Date.strptime(text, "%Y-%m-%d")
      rescue ArgumentError
        fail(BotError, "date_format_invalid")
      end

      def parse_subject_name(text)
        range = (1..MAX_SUBJECT_NAME_LENGTH)
        name = text.downcase
        fail(BotError, "subject_name_invalid") unless range.cover?(name.length)
        name
      end

      def parse_work_number(text)
        range = (1..MAX_NUMBER_OF_WORKS)
        number = text.to_i
        fail(BotError, "work_number_invalid") unless range.cover?(number)
        number
      end

      def parse_number_works(text)
        range = (1..MAX_NUMBER_OF_WORKS)
        number = text.to_i
        fail(BotError, "works_number_invalid") unless range.cover?(number)
        number
      end
    end
  end
end
