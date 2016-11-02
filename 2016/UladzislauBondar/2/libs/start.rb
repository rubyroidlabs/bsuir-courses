require_relative 'command'

module Command
  # Start-command class
  class Start < Base
    def self.name
      "/start"
    end

    def process
      send_message("Hi, #{user.first_name}! I'll help you to pass all works right on time.")
      send_message("/semester - keep date of current semester's end")
      send_message("/subject - submit new subject and quantity of works")
      send_message("/status - show quantity of unpassed works for every subject")
      send_message("/reset - delete your data")
      save_user_command
    end
  end
end
