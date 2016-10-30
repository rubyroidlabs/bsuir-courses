module BotCallback
  # Class for handling callback of subject removal
  class SubjectDelete < Base
    def should_start?
      callback_data[0] =~ /subject-delete/
    end

    def start
      subj_name = callback_data[1]
      user.del_subject(subj_name)
      user.callback = nil
      text = Responses::SUBJ_DELETE_OK.sub('[S]', subj_name)
      edit_inline_message(text)
    end
  end
end
