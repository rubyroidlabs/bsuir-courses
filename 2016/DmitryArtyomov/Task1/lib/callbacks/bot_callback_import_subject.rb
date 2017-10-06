module BotCallback
  # Class for importing user subject
  class ImportSubject < Base
    def should_start?
      callback_data[0] =~ /import-subject/
    end

    def start
      subject = callback_data[1]
      form_callback_message(subject)
    end

    private

    def form_callback_message(subject_name)
      kb = create_keyboard(subject_name)
      edit_inline_message(
        Responses::SUBJ_COUNT.sub('[S]', subject_name),
        markup(kb)
      )
    end

    def create_keyboard(subj_name)
      keyboard = []
      (1..20).each do |i|
        add_button(keyboard, subj_name, i.to_s)
      end
      keyboard = keyboard.each_slice(5).to_a
      add_cancel_callback_button(keyboard)
      keyboard
    end

    def add_button(keyboard, subj, labs)
      keyboard.push(
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: labs,
          callback_data: "import-labs/#{subj}/#{labs}"
        )
      )
    end
  end
end
