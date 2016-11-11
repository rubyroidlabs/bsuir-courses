module Bot
  module ResponseParticle
    # Base class for a text particle which are used for user interaction
    class Base
      include Bot::TranslationHelpers

      attr_reader :user

      def initialize(user)
        @user = user
      end

      def text
        fail NotImplementedError
      end
    end
  end
end
