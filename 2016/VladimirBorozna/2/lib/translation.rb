module Bot
  module Translation # :nodoc:
    def translate(name, options = {})
      lookup = "#{command_scope}.#{name}"
      I18n.t(lookup, options.merge(default: name.to_sym))
    end

    def command_response(name, options = {})
      lookup = "#{command_scope}.response.#{name}"
      I18n.t(lookup, options.merge(default: name.to_sym))
    end

    def error(name, options = {})
      lookup = "#{command_scope}.errors.#{name}"
      I18n.t(lookup, options.merge(default: "errors.#{name}"))
    end

    def callback_response(name, options = {})
      lookup = "#{callback_scope}.response.#{name}"
      I18n.t(lookup, options.merge(default: name.to_sym))
    end

    def callback_scope
      "callbacks.#{callback_name}"
    end

    def callback_name
      self.class
          .to_s
          .split("::")
          .last
          .gsub(/(.)([A-Z])/, '\1_\2')
          .downcase
    end

    def command_name
      self.class.to_s.sub(/.*Command::/, "").downcase
    end

    def command_scope
      "commands.#{command_name}"
    end
  end
end
