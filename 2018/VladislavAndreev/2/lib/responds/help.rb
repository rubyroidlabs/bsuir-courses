# frozen_string_literal: true

require_relative 'message_responder'

class HelpResponder < MessageResponder
  def respond
    answer_with_message(<<-HELP_MESSAGE
      Список поддерживаемых комманд:
      /set\\_repo <repo> - Установить ссылку на репозиторий
      /show\\_repo - Отобразить установленный репозиторий
      /search <text> - Поиск среди сообщений
      /history - История поиска
      /help - Вызов данного сообщения
                        HELP_MESSAGE
                       )
  end
end
