require_relative 'search_engine'
require 'translit'

class MessageResponder
  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @redis = options[:redis]
    @chat = @message.chat
  end

  def respond
    on(%r{^\/start}) do
      answer_with_message('Дароу')
    end

    on(%r{^\/stop}) do
      answer_with_message('Прощай')
    end

    on(%r{^\/list}) do
      answer_with_message(@redis.all_names.join("\n"))
    end

    on(/^\w+(\s\w+){,2}$/) do |name|
      result = SearchEngine.new(@redis).search(name.to_s)
      if result.is_a? String
        text = "#{result}\n"
        comment = @redis.comment_by_name(result)
        comment = 'Без комментариев!' if comment.empty?
        text << comment
        answer_with_message(text)
      elsif result.any?
        text = "Вы имели ввиду кого-то из них?\n"
        result.each { |lname| text << "#{lname}\n" }
        answer_with_message(text)
      else
        answer_with_message('Я его не знаю :(')
      end
    end
  end

  private

  def on(regex, &block)
    message_text = @message.text.strip
    Translit.convert!(message_text, :english)
    regex =~ message_text

    return unless $~
    if block.arity.zero?
      yield
    else
      yield $~
    end
  end

  def answer_with_message(text)
    @bot.api.send_message(chat_id: @chat.id, text: text)
  end

end
