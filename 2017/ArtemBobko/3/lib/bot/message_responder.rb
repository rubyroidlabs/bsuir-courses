require './lib/bot/message_sender'
require './lib/parser/check_celebtity'

class MessageResponder
  attr_reader :message
  attr_reader :bot

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
  end

  def respond
    on(/(.+)/) do |name|
      get_answer(name) # if name.scan(/\//) != ['/']
    end
  end

  private

  def on(regex, &block)
    regex =~ message.text

    if $~
      case block.arity
      when 0
        yield
      when 1
        yield $1
      when 2
        yield $1, $2
      end
    end
  end

  def get_answer(name)
    if CheckCelebrity.lgbt?(name)
      answer_with_message 'Да'
    else
      answer_with_message 'Не найдено данных'
    end
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end
end
