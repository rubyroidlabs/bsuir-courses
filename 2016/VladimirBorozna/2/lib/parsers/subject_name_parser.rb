module Bot
  # Class is used for handling raw user data
  class SubjectNameParser
    MIN_NAME_LENGTH = 2
    MAX_NAME_LENGTH = 20
    SUBJECT_NAME_RANGE = (MIN_NAME_LENGTH...MAX_NAME_LENGTH)

    class << self
      def parse(text)
        validate_name(text)
      end

      private

      def validate_name(name)
        check = SUBJECT_NAME_RANGE.cover?(name.length)
        fail(BotError, "subject_name_invalid") unless check
        name
      end
    end
  end
end
