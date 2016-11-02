require_relative 'command'

module Command
  # Status-command class
  class Status < Base
    def self.name
      "/status"
    end

    def process
      if got_data?
        send_message("By now you should have passed:")
        hash_of_subjects.each do |k, v|
          send_message(done_works_message(k, v))
        end
        send_message("C'mon!")
      else
        send_message("Nothing to pass. Add some subjects first!")
      end
      save_user_command
    end

    private

    def got_data?
      !hash_of_subjects.empty? && !semester_end.nil?
    end

    def done_works_message(name, quantity)
      done_works = (quantity * percent_of_done_works).to_i
      "#{name} - #{done_works} of #{quantity}"
    end

    def percent_of_done_works
      semester_length = 120.0
      left_days = Date.parse(semester_end) - Date.today
      1 - left_days / semester_length
    end

    def semester_end
      @redis.hget('users_semester_ends', user_id)
    end

    def subjects
      @redis.hget('users_subjects', user_id)
    end

    def hash_of_subjects
      JSON.parse(subjects)
    end
  end
end
