module BotCommand
  # undefined command
  class Undefined < Base
    def start
      send_message("Ты что-то неправильно ввёл. Введи /start чтобы узнать на какие команды  я отвечаю.")
    end
  end
end
