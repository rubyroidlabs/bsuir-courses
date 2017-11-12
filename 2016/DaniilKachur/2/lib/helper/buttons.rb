module Helper
  # useful methods for creating telegram buttons
  module Buttons
    def keyboard_buttons(button_list)
      { reply_markup: { inline_keyboard: button_list }.to_json }
    end

    def subject_button_list
      user.subjects.keys.each.inject([]) do |buttons, subject|
        buttons << [text: subject.to_s, callback_data: subject.to_s]
      end
    end

    def labs_button_list
      not_passed_labs.each.inject([]) do |buttons, lab|
        buttons << [text: lab.to_s, callback_data: lab.to_s]
      end
    end
  end
end
