require_relative "command"

module Command
  # Reset-command class
  class Reset < Base
    def self.name
      "/reset"
    end

    def process
      @user.delete_semester
      @user.clear_subjects
      send_message("Data removed.")
      @user.save_command
    end
  end
end
