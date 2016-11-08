require "bundler"
Bundler.require(:default)
require "telegram/bot"
require_all "lib/models/*"
require_all "lib/response_particles/*"
require_relative "../translation"
require_relative "../configuration"
require_relative "../../config/application"

class NotifyWorker # :nodoc:
  include Sidekiq::Worker
  include Bot::Translation

  API_REQUESTS_PER_SECOND = 30
  attr_reader :api

  def initialize
    @api = Bot.configuration.api
  end

  def every_second
    yield
    sleep(1)
  end

  def perform
    users = Bot::User.all.select(&:can_notify?)
    users.each_slice(API_REQUESTS_PER_SECOND) do |users_slice|
      every_second do
        users_slice.each do |user|
          text = translate('response_particles.notification') << "\n"
          text << Bot::Response::SubjectsStatus.new(user).message
          send_message(user, text)
        end
      end
    end
  end

  def send_message(user, text)
    api.call(
      "sendMessage",
      chat_id: user.telegram_id,
      text:    text
    )
  end
end
