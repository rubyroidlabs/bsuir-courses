module Bot
  module Command
    # Class for the command - /reset
    class Reset < Base
      def start
        destroy_user_data
        send_message(command_response("confirmation"))
      end

      private

      def destroy_user_data
        destroy_subjects
        next_command.delete
        user.semester.delete
        user.delete
      end

      def destroy_subjects
        subject_set = user.subjects
        subject_set.each { |subject| subject_set.delete(subject) }
      end
    end
  end
end
