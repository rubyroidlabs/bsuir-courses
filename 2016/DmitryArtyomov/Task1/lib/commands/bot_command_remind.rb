module BotCommand
  # Class for outputting reminds manager
  class Remind < Base
    def should_start?
      text =~ %r{/remind}
    end

    def start
      @reminders = Reminders.new
      list_reminders = @reminders.list_text(user_id)
      kb = create_keyboard
      sent_msg_id = send_message_inline(
        list_reminders,
        markup(kb)
      )
      add_callback('remind-manage', sent_msg_id)
    end

    private

    def create_keyboard
      keyboard = []
      add_button(keyboard, Responses::REMINDER_ADD_BUTTON, 'remind-add-start')
      add_button(
        keyboard,
        Responses::REMINDER_DEL_BUTTON,
        'remind-delete-choose'
      ) unless @reminders.user_empty?(user_id)
      add_cancel_callback_button(keyboard)
      keyboard
    end

    def add_button(keyboard, text, cb_data)
      keyboard.push(
        Telegram::Bot::Types::InlineKeyboardButton
        .new(text: text, callback_data: cb_data)
      )
    end
  end
end
