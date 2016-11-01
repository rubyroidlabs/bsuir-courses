module Bot
  module Command
    # Class for the command - /status
    class Subject < Base
      def start
        raise BotError, 'semester_dates_not_found' unless user.semester_present?
        send_message(response('subject_name_question'))
      end

      def subject_name
        name = Parser.parse_subject_name(text)
        raise BotError, 'subject_name_invalid' unless user.semester_present?
        raise BotError, 'subject_name_not_uniq' if user.subject_present?(text)

        user.next_command_data(name)
        send_message(response('number_works_question'))
      end

      def subject_number_works
        number = Parser.parse_number_works(text)
        subject_name = user.command_data
        subject_data = {
          name: subject_name,
          total_number: number,
          accepted_numbers: []
        }
        user.subjects.add(Bot::Subject.create(subject_data))
        send_message(response('confirmation'))
      end

      def select_next_command
        case user.method
        when nil
          user.next_command(class_name, 'subject_name')
        when 'subject_name'
          user.next_command(class_name, 'subject_number_works')
        when 'subject_number_works'
          user.reset_next_command
        end
      end
    end
  end
end
