module BotCommand
  # start command
  class Start < Base
    def should_start?
      text == "/start"
    end

    def start
      send_message("Привет. Я помогу тебе сдать все лабы, " \
                "чтобы мамка не ругалась. Смотри что я умею:\n" \
              "/start - выводит приветствие и описание всех доступных команд\n" \
              "/semester - запоминает даты начала и конца семестра\n" \
              "/subject - добавляет предмет и количество лабораторных работ по нему\n" \
              "/submit - отмечает какие лабы уже сдал\n" \
              "/status - выводит список лаб, которые тебе предстоит сдать\n" \
              "/reset - сбрасывает для пользователя все данные")
      user.reset_next_bot_command
    end
  end
end
