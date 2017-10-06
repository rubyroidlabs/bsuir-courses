require_relative "command"

module Command
  # Status-command class
  class Status < Base
    def self.name
      "/status"
    end

    def process
      if got_data? && semester_entered?
        send_status_message
      elsif !got_data?
        send_message("Nothing to pass. Try /subject")
      elsif !semester_entered?
        send_message("Did you entered /semester ?")
      end
      @user.save_command
    end

    private

    def send_status_message
      send_message("By now you should have passed:")
      subjects.each do |name, works|
        response = works_message(name, works)
        send_message(response) unless response.nil?
      end
      send_message("C'mon!")
    end

    def got_data?
      !subjects.empty?
    end

    def semester_entered?
      !semester_end.nil? && !semester_start.nil?
    end

    def works_message(name, works)
      quantity = works.size
      done = done_works(works)
      n_of_must_done_works = (quantity * percent_of_done_works).to_i
      n_of_left_works = n_of_must_done_works - done.size
      response = must_done_works_message(works, n_of_left_works)
      "#{name} - #{response}" if n_of_left_works.positive?
    end

    def undone_works(works)
      works.select { |_, v| v }.keys
    end

    def done_works(works)
      works.select { |_, v| !v }.keys
    end

    def must_done_works_message(works, n_of_left_works)
      undone = undone_works(works)
      result = ""
      n_of_left_works.times do |i|
        result << undone[i]
        result << " "
      end
      result
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
