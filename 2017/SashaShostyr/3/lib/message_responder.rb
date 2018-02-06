require_relative 'message_sender'
require_relative 'helper'

class MessageResponder
  attr_reader :message
  attr_reader :bot

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @data = options[:data]
  end

  def respond
    case @message.text
    when '/start'
      answer_with_greeting_message
    when '/stop'
      answer_with_farewell_message
    else
      get_answer(@message.text.upcase)
    end
  end

  def answer_with_greeting_message
    answer_with_message "Привет, #{get_user}"
  end

  def answer_with_farewell_message
    answer_with_message "Пока, #{get_user}"
  end

  def get_user
    "#{@message.from.first_name} #{@message.from.last_name}"
  end

  def get_answer(name)
    list_names = @data.keys
    if list_names.include? name
      answer_with_message get_info(name)
    else
      suggested_name = Helper.find(name)
      answers = %w[Да Нет]
      answer_with_answers("Вы имеете ввиду \'#{suggested_name}\'?", answers)
      confirmation = confirm(suggested_name)
      answer_with_message confirmation
    end
  end

  def get_info(name)
    info = "#{name} - #{@data[name]['orientation']}\n"
    info << "<a href='#{@data[name]['uri']}'>Biography</a>"
    info
  end

  def confirm(name)
    @bot.listen do |answer|
      case answer.text
      when 'Да'
        info = get_info(name)
        return info
      when 'Нет'
        return 'Нет данных!!!'
      end
    end
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end

  def answer_with_answers(t, ans)
    MessageSender.new(bot: bot, chat: message.chat, text: t, answers: ans).send
  end
end
