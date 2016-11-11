module Bot
  module ResponseParticle
    class SubjectsStatus < Base # :nodoc:
      CHECKMARK = "\u2713".freeze

      def text
        result = translate("response_particles.required_work_title") << "\n"
        result << status_of_subjects
      end

      def status_of_subjects
        coefficient = user.semester.required_coefficient
        user.subjects.inject("") do |result, subject|
          result << subject_status(subject, coefficient) << "\n"
        end
      end

      def subject_status(subject, coefficient)
        required_numbers = subject.required_numbers(coefficient).join(", ")
        required_numbers = CHECKMARK if required_numbers.empty?

        translate(
          "response_particles.subject_status",
          subject_name:     subject.name,
          required_numbers: "-  #{required_numbers}",
          performed_number: subject.accepted_numbers.size,
          total_number:     subject.total_number
        )
      end
    end
  end
end
