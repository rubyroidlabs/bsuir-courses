require "erb"
require "i18n/backend/pluralization"

module Bot #:nodoc:
  class << self
    attr_reader :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  class Configuration #:nodoc:
    attr_reader   :bot_token
    attr_reader   :api
    attr_reader   :env
    attr_accessor :webhook_path

    def initialize
      setup_environment
      setup_i18n
      setup_bot_token
      setup_api
      setup_database
    end

    def add_plurazation(locale, rule, keys)
      plural = { i18n: { plural: { keys: keys, rule: rule } } }
      I18n.backend.store_translations(locale, plural, escape: false)
    end

    private

    def setup_environment
      @env = ENV["RACK_ENV"] || "development"
    end

    def setup_bot_token
      secrets = YAML.load(ERB.new(IO.read("config/secrets.yml")).result)
      @bot_token = secrets[env]["telegram_bot_token"]
    end

    def setup_api
      @api = ::Telegram::Bot::Api.new(bot_token)
    end

    def setup_database
      config = YAML.load(ERB.new(IO.read("config/redis.yml")).result)
      redis_url = config[env]["database_url"]
      Ohm.redis = Redic.new(redis_url)
    end

    def setup_i18n
      I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)
      I18n.config.available_locales = [:en, :ru]
      I18n.load_path = Dir["config/locales.yml"]
      I18n.default_locale = :ru
      I18n.backend.load_translations
    end
  end
end
