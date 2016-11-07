module BotCallback
  # Class for stopping importing subjects
  class ImportStop < Base
    def should_start?
      callback_data[0] =~ /import-stop/
    end

    def start
      edit_inline_message(Responses::IMPORT_STOPPED)
      remove
    end
  end
end
