require_relative "command"

module Command
  # Submits done works of a particular subject
  class Submit < Base
    NAME = 0
    WORK = 1

    def self.name
      "/submit"
    end

    def process
      show_keyboard("Subject?", subjects_names)
      @user.save_submit_step(NAME)
    end

    def process_subject
      @subject = text
      if valid_subject?
        @user.save_current_submitted_subject(@subject)
        show_keyboard("Work?", works_names)
        @user.save_submit_step(WORK)
      else
        send_message("You didn't specify this subject :c")
      end
    end

    def process_work
      @work = text
      if valid_work?
        uncheck_work
        hide_keyboard("Well done!")
        @user.save_command
      else
        send_message("You didn't specify this work :c")
      end
    end

    private

    def valid_subject?
      subjects.keys.include? @subject
    end

    def valid_work?
      works.keys.include? @work
    end

    def uncheck_work
      hash = subjects
      hash[current_subject][@work] = false
      @user.save_subjects(hash)
    end

    def subjects_names
      subjects.keys
    end

    def works_names
      works.select { |_, v| v == true }.keys
    end

    def subjects
      JSON.parse(@user.subjects)
    end

    def works
      subjects[current_subject]
    end

    def current_subject
      @user.current_submitted_subject
    end
  end
end
