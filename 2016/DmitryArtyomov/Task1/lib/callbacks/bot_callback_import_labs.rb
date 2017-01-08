require 'json'

module BotCallback
  # Class for importing labs on user subject
  class ImportLabs < Base
    def should_start?
      callback_data[0] =~ /import-labs/
    end

    def start
      add_subject
      subjects = JSON.parse(user.callback.split('/')[1])
      subjects -= [callback_data[1]]
      if subjects.empty?
        no_subjects_left
        return
      end
      form_callback_message(subjects)
    end

    private

    def add_subject
      user.add_subject(callback_data[1], callback_data[2].to_i)
    end

    def no_subjects_left
      edit_inline_message("#{subject_added}\n#{Responses::IMPORT_STOPPED}")
      remove
    end

    def subject_added
      Responses::SUBJ_OK
        .sub('[N]', callback_data[2])
        .sub('[S]', callback_data[1])
    end

    def form_callback_message(subjects)
      kb = create_keyboard(subjects)
      edit_inline_message(
        "#{subject_added}\n#{Responses::IMPORT_WHAT_SUBJECTS}",
        markup(kb)
      )
      add("import-subject/#{subjects.to_json}")
    end

    def create_keyboard(subjects)
      keyboard = []
      subjects.each do |subj|
        add_button(keyboard, subj)
      end
      add_stop_import_button(keyboard)
      keyboard
    end

    def add_stop_import_button(keyboard)
      keyboard.push(
        Telegram::Bot::Types::InlineKeyboardButton
        .new(text: Responses::IMPORT_STOP_BUTTON, callback_data: 'import-stop')
      )
    end

    def add_button(keyboard, subj)
      keyboard.push(
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: subj,
          callback_data: "import-subject/#{subj}"
        )
      )
    end
  end
end
