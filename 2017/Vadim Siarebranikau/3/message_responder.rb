require './lib/message_sender'
require_relative 'parser.rb'
class MessageResponder
  attr_reader :message
  attr_reader :bot

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @answer=nil
  end

  def respond
    if @message.text == '/start'
      answer_with_greeting_message
    elsif @message.text == '/stop'
      answer_with_farewell_message
    else
      answer
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

  def answer_with_greeting_message
    answer_with_message "Привет,#{@message.from.first_name}"
  end

  def answer_with_farewell_message
    answer_with_message "Пока,#{@message.from.first_name}"
  end

  def answer
    @answer = Parser.new.search(@message.text)
    answer_with_message @answer
  end
  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end
end
