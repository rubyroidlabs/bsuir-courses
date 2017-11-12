module Bot
  # Module contains helper methods for message translation
  module TranslationHelpers
    def translate(name, options = {})
      I18n.t(name, options)
    end

    def command_response(name, options = {})
      I18n.t("#{command_scope}.#{class_name}.responses.#{name}", options)
    end

    def callback_response(name, options = {})
      I18n.t("#{callback_scope}.#{class_name}.responses.#{name}", options)
    end

    def translate_error(name, options = {})
      I18n.t("#{error_scope}.#{name}", options)
    end

    def error_scope
      "errors"
    end

    def callback_scope
      "callbacks"
    end

    def command_scope
      "commands"
    end

    def class_name
      self.class.to_s.split("::").last.gsub(/(.)([A-Z])/, '\1_\2').downcase
    end
  end
end
