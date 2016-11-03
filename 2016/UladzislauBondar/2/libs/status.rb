require_relative "command"

module Command
  # Status-command class
  class Status < Base
    def self.name
      "/status"
    end

    def process
      if got_data?
        send_message("By now you should have passed:")
        subjects.each do |k, v|
          send_message(done_works_message(k, v))
        end
        send_message("C'mon!")
      else
        send_message("Nothing to pass. Add some subjects first!")
      end
      @user.save_command
    end

    private

    def got_data?
      !subjects.empty? && !semester_end.nil? && !semester_start.nil?
    end

    def done_works_message(name, quantity)
      done_works = (quantity * percent_of_done_works).to_i
      "#{name} - #{done_works} of #{quantity}"
    end

    def percent_of_done_works
      semester_length = Date.parse(semester_end) - Date.parse(semester_start)
      left_days = Date.parse(semester_end) - Date.today
      1 - left_days / semester_length
    end

    def semester_end
      @user.semester_end
    end

    def semester_start
      @user.semester_start
    end

    def subjects
      JSON.parse(@user.subjects)
    end
  end
end
