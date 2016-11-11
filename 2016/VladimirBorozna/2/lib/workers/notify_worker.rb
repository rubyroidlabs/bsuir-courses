require "bundler"
Bundler.require(:default)
require "telegram/bot"

require_relative "../date_extended"
require_relative "../translation"
require_relative "../configuration"
require_relative "../../config/application"

require_all "lib/models/*"
require_all "lib/response_particles/*"

class NotifyWorker # :nodoc:
  include Sidekiq::Worker
  include Bot::TranslationHelpers

  API_REQUESTS_PER_SECOND = 30
  attr_reader :api

  def initialize
    @api = Bot.configuration.api
  end

  def perform
    users = Bot::User.all.select { |user| user.notification.can_notify? }
    users.each_slice(API_REQUESTS_PER_SECOND) do |users_slice|
      every_second do
        process(users_slice)
      end
    end
  end

  private

  def every_second
    yield
    sleep(1)
  end

  def process(users_slice)
    users_slice.each do |user|
      text = notification_text(user)
      send_message(text, user)
      user.notification.update_timestamp
    end
  end

  def notification_text(user)
    text = translate("response_particles.notification_title") << "\n"
    text << Bot::ResponseParticle::SubjectsStatus.new(user).text
  end

  def send_message(text, user)
    api.call("sendMessage", chat_id: user.telegram_id, text: text)
  end
end
