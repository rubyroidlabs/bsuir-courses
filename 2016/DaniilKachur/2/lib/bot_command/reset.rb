module BotCommand
  # reset command
  class Reset < Base
    def should_start?
      text == "/reset"
    end

    def start
      user.clean_all_data
      user.reset_next_bot_command
      send_message("Все почистили. Теперь не то что мама, даже гугл не узнает о твоих хвостах.")
    end
  end
end
