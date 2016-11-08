russian_rule = lambda do |n|
  if n.zero?
    :zero
  elsif ((n % 10) == 1) && ((n % 100 != 11))
    :one
  elsif [2, 3, 4].include?(n % 10) && ![12, 13, 14].include?(n % 100)
    :few
  elsif (n % 10).zero? ||
        ![5, 6, 7, 8, 9].include?(n % 10) ||
        ![11, 12, 13, 14].include?(n % 100)
    :many
  end
end
keys = [:zero, :one, :few, :many]

Bot.configure do |config|
  config.add_plurazation(:ru, russian_rule, keys)
  config.webhook_path = "/#{config.bot_token}"
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_SIDEKIQ_URL"], size: 10 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_SIDEKIQ_URL"], size: 10 }
end

module Clockwork # :nodoc:
  configure do |config|
    config[:tz] = "UTC"
    config[:max_threads] = 15
    config[:thread] = true
  end
end
