require 'json'

module BotAction
  # Class for handling input of subject name
  class ImportGroup < Base
    def should_start?
      user.action[0] =~ /IMPORT_GROUP/
    end

    def start
      @ds = DataStorage.instance
      return unless check_group?(text)
      subjects = @ds.get_group_subjects(text)
      form_callback_message(subjects) if check_subjects?(subjects)
      action_handler.del_action(user)
    end

    private

    def check_group?(group)
      return true if @ds.group_exists?(group)
      action_handler.del_action(user, Responses::IMPORT_NO_GROUP)
      false
    end

    def form_callback_message(subjects)
      kb = create_keyboard(subjects)
      msg_id = send_message_inline(Responses::IMPORT_WHAT_SUBJECTS, markup(kb))
      add_callback("import-subject/#{subjects.to_json}", msg_id)
    end

    def check_subjects?(subjects)
      if subjects.empty?
        send_message(Responses::IMPORT_NO_SUBJECTS)
        return nil
      end
      subjects.reject! { |subj| user.subject?(subj) }
      if subjects.empty?
        send_message(Responses::IMPORT_ALL_EXIST)
        return nil
      end
      true
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
