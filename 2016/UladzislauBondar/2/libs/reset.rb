require_relative 'command'

module Command
  # Reset-command class
  class Reset < Base
    def self.name
      "/reset"
    end

    def process
      delete_semester_end
      delete_subjects
      send_message("Data removed.")
      save_user_command
    end

    private

    def delete_semester_end
      @redis.del('users_semester_ends', user_id)
    end

    def delete_subjects
      @redis.del('users_subjects', user_id)
      @redis.hset('users_subjects', user_id, {})
    end
  end
end
