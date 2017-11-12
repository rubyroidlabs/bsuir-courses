Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_SIDEKIQ_URL"] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_SIDEKIQ_URL"] }
end

module Clockwork # :nodoc:
  configure do |config|
    config[:tz] = "UTC"
    config[:max_threads] = 15
    config[:thread] = true
  end
end
