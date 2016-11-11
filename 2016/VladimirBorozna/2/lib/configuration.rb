require "erb"

# Bot namespace
module Bot
  # Class sets the main settings for the bot
  class Configuration
    attr_reader   :bot_token
    attr_reader   :api
    attr_reader   :enviroment
    attr_reader   :webhook_path

    def initialize
      setup_environment
      setup_i18n
      setup_bot_token
      setup_api
      setup_webhook
      setup_database
    end

    private

    def setup_webhook
      @webhook_path = "/#{bot_token}"
    end

    def setup_environment
      @enviroment = ENV["RACK_ENV"] || "development"
    end

    def setup_bot_token
      secrets = YAML.load(ERB.new(IO.read("config/secrets.yml")).result)
      @bot_token = secrets[enviroment]["telegram_bot_token"]
    end

    def setup_api
      @api = ::Telegram::Bot::Api.new(bot_token)
    end

    def setup_database
      config = YAML.load(ERB.new(IO.read("config/redis.yml")).result)
      redis_url = config[enviroment]["database_url"]
      Ohm.redis = Redic.new(redis_url)
    end

    def setup_i18n
      I18n.config.available_locales = [:en, :ru]
      I18n.load_path = Dir["config/locales.yml"]
      I18n.default_locale = :ru
      I18n.backend.load_translations
    end
  end

  class << self
    attr_reader :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
