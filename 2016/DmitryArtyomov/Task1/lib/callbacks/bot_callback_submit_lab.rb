module BotCallback
  # Class for handling callback of lab number submit
  class SubmitLab < Base
    def should_start?
      callback_data[0] =~ /submit-lab/
    end

    def start
      subj_name = callback_data[1]
      lab = callback_data[2].to_i
      user.submit_subject_lab(subj_name, lab)
      user.callback = nil
      text = Responses::SUBM_OK.sub('[N]', (lab + 1).to_s).sub('[S]', subj_name)
      edit_inline_message(text)
    end
  end
end
