module BotCallback
  # Class for adding user subject
  class SubjectAdd < Base
    def should_start?
      callback_data[0] =~ /subject-add/
    end

    def start
      user.add_subject(callback_data[1], callback_data[2].to_i)
      edit_inline_message(
        Responses::SUBJ_OK
          .sub('[N]', callback_data[2])
          .sub('[S]', callback_data[1])
      )
      remove
    end
  end
end
