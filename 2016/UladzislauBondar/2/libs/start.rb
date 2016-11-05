require_relative "command"

module Command
  # Start-command class
  class Start < Base
    def self.name
      "/start"
    end

    def process
      send_message("Hi, #{user.first_name}! I'll help you to pass all works right on time.")
      send_message("/semester - keep dates of current semester")
      send_message("/subject - submit new subject and quantity of works")
      send_message("/submit - submit a work that you've passed")
      send_message("/status - show what works you need to pass for every subject")
      send_message("/reset - delete your data")
      @user.save_command
    end
  end
end
