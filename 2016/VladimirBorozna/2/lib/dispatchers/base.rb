module Bot
  # Base class of dispachers
  class Dispatcher
    include Bot::Translation
    attr_reader :api, :user

    def initialize(api, user)
      @api = api
      @user = user
    end

    def dispatch
      fail(NotImplementedError)
    end
  end
end
