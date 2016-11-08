module Bot
  module Response
    class Base # :nodoc:
      include Bot::Translation

      attr_reader :user

      def initialize(user)
        @user = user
      end

      def message
        fail NotImplementedError
      end
    end
  end
end
