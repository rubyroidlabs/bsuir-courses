require 'telegram/bot'

token = ''

semestr_begin_flag = false

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::Message
      if /^\/[a-z]{1,6}?/ =~ message.text
        case message.text
        when '/start'
          bot.api.sendMessage(chat_id: message.chat.id, text: "#{message.from.first_name}
                                                                привет.
                                                                Я могу тебе помочь сдать вовремя все лабы.
                                                                Вот список того, что я умею:\n
                                                                /start - Приветствие и отображение всех доступных команд
                                                                /semester - Ввод даты начала и конца семестра
                                                                /subject - Добавляет предмет и количество лабораторных работ по нему
                                                                /status - Отображает список лабораторных работ, которые нужно сдать
                                                                /submit - Учитывает сдачу лабораторной работы ( Я сдал(а) )
                                                                /reset - Сбрасывает и удаляет все пользовательские данные
                                                               ")
        when '/semester'
          bot.api.sendMessage(chat_id: message.chat.id, text: "Когда начинаем учиться (ДД-ММ-ГГГГ) ?")
        when '/subject'
          bot.api.sendMessage(chat_id: message.chat.id, text: "Какой предмет учим?")
        when '/status'
          bot.api.sendMessage(chat_id: message.chat.id, text: "К этому времени у тебя должно было быть сдано:")
        when '/submit'
          bot.api.sendMessage(chat_id: message.chat.id, text: "Молодец! Какой предмет сдал(а)?")
        when '/reset'
          bot.api.sendMessage(chat_id: message.chat.id, text: "Твои данные, #{message.from.first_name}, будут удалены. Этот процесс *необратим*. Продолжить?",  parse_mode: 'Markdown')
        else bot.api.send_message(chat_id: message.chat.id, text: "Моя твоя не понимать. :(
                                                                   Для просмотра доступных комманд используйте '/start'
                                                                  ")
        end
      elsif /^\d{2}\-{1}\d{2}\-{1}\d{4}$/ =~ message.text && semestr_begin_flag == true
        semestr_end = message.text
      elsif /^\d{2}\-{1}\d{2}\-{1}\d{4}$/ =~ message.text
        semestr_begin = message.text
        semestr_begin_flag = true
        bot.api.sendMessage(chat_id: message.chat.id, text: "Когда дедлайн (ДД-ММ-ГГГГ) ?")
      end
    end
  end
end
