
class MessageResponder
  attr_reader :bot, :message, :name, :text

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @name = options[:name]
    @text = options[:text]
  end

  def get_answer
    text = respond_message
    send_message(text) if text
  end

  private

  def send_message(text)
    bot.api.send_message(chat_id: message.chat.id, text: text)
  end

  def respond_message
    case message.text
      when '/start'
        return "#{message.from.first_name} вас приветствует ComingOutBot! Я мо"\
               "гу определять известных людей, которые совершили каминг-аут.\n"\
               "Введите имя и фамилию любой знаменитости:"
      when '/stop'
        return "#{message.from.first_name}, я буду тебя ждать! Возвращайся, ес"\
               "ли захочешь проверить ещё какого-нибудь известного человека."
      when ->(mes) {mes.strip.index(' ')}# if the name and surname
        return respond_celebrity(name)
      else # if only surname
        return respond_celebrity(name.split(' ').last)
    end
  end

  def respond_celebrity(name)
    case message.text
      when name # check for an exact match
        return check_info
      when ->(mes) {simple_fuzzy_match(mes, name)} # check for similarity
        return correction
      else
        return
    end
  end

  def check_info
    if text
      return "#{name}\n#{text}"
    end
    "#{name} совершил(а) каминг-аут! Подробная информация отсутствует"
  end

  def correction
    send_message "Возможно вы имели в виду #{name}\n1.Да\n2.Нет\n3.Назад"
    bot.listen do |confirmation|
      answer = respond_confirmation(confirmation)
      return answer unless answer == 'error'
    end
  end

  def respond_confirmation(confirmation)
    case confirmation.text
      when '1', 'Да'
        return check_info
      when '2', 'Нет'
        return
      when '3', 'Назад'
        return "#{message.text} не совершал(а) каминг-аут!"
      else
        send_message'Ошибка! Введите "Да", "Нет", "Назад" или номер выбра'\
                         'нного варианта!'
        return 'error'
    end
  end
end
