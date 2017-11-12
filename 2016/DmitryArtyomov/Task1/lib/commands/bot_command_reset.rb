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
      sent_msg_id = send_message_inline(Responses::RESET, markup(keyboard))
      add_callback('reset', sent_msg_id)
    end
  end
end
