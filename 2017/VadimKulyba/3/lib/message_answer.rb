require 'redis'
require 'yandex-translator'
require_relative 'parser/imdb_parser'
require_relative 'parser/new_now_next_parser'

class MessageAnswer
  API_KEY = 'trnsl.1.1.20171112T000610Z.0783b6754dc6080d.991c3be68c6300' \
            'df5e0f32c1b9ef483eba4977fd'.freeze
  attr_reader :message
  attr_reader :old_message
  attr_reader :bot
  attr_reader :redis
  attr_reader :translator

  def initialize
    @old_message = "I don't know"
    @redis = Redis.new(port: 6379, db: 7)
    @translator = Yandex::Translator.new(API_KEY)
    IMDBParser.new.parse(@redis)
    NewNowNextParser.new.parse(@redis)
  end

  def init_message(options)
    @bot = options[:bot]
    @message = options[:message]
  end

  def respond
    if redis.get(message.text).nil?
      case message.text
      when '/start'
        send("Hello, #{message.from.first_name}")
      when '/stop'
        send('Goodbye')
      when 'yes'
        if redis.get(old_message).nil?
          send(old_message)
        else send(redis.get(old_message))
        end
        @old_message = "I don't know"
      else
        @old_message = translate(message.text)
      end
    else
      send(redis.get(message.text))
    end
  end

  private

  def send(text)
    bot.api.send_message(chat_id: message.chat.id, text: text)
  end

  def translate(message)
    en = translator.translate message, from: 'en'
    if !redis.get(en).nil?
      send("Perhaps #{en}?")
    else
      send(en = 'Input error')
    end
    en
  end
end
