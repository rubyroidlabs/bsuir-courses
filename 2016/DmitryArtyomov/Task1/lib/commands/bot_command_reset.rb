module BotCommand
  # Class for user reset command
  class Reset < Base
    def should_start?
      text =~ %r{/reset}
    end

    def start
      keyboard = []
      keyboard.push(
        Telegram::Bot::Types::InlineKeyboardButton
        .new(text: 'Удалить', callback_data: 'reset')
      )
      add_cancel_callback_button(keyboard)
      send_message_inline(Responses::RESET, markup(keyboard))
      user.callback = 'reset'
    end
  end
end
