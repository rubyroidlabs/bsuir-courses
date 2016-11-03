module BotCommand
  # Class for /status command
  class Status < Base
    def should_start?
      text =~ %r{/status}
    end

    def start
      return unless check_sem?
      return unless check_subjects?

      needed_labs
      @needed_msg = @result_msg
      all_labs

      send_message(sem_text + "\n\n" + @needed_msg + @result_msg)
    end

    private

    def needed_labs
      @result_msg = ''
      lab_count_needed = { total: 0, left: 0, needed: 0 }
      count_labs_needed(lab_count_needed)
      form_message_needed(lab_count_needed)
    end

    def all_labs
      @result_msg = ''
      lab_count_all = { total: 0, left: 0, needed: 0 }
      count_labs_all(lab_count_all)
      form_message_all(lab_count_all)
    end

    def check_sem?
      if !user.sem_defined?
        send_message(Responses::STATUS_SEM_ERR)
        false
      elsif !user.sem_now?
        send_message(Responses::SEM_ERR)
        false
      else
        true
      end
    end

    def check_subjects?
      if user.subjects?
        true
      else
        send_message(Responses::NO_SUBJ)
        false
      end
    end

    def form_message_needed(lab_count)
      if lab_count[:left].zero?
        @result_msg = Responses::STATUS_1_COOL
      else
        @result_msg = Responses::STATUS_1 +
                      @result_msg +
                      Responses::STATUS_1_END
                      .sub('[L]', lab_count[:left].to_s)
                      .sub('[T]', lab_count[:total].to_s)
      end
    end

    def form_message_all(lab_count)
      if lab_count[:left].zero?
        @result_msg = Responses::STATUS_2_COOL
        @needed_msg = ''
      else
        @result_msg = Responses::STATUS_2 +
                      @result_msg +
                      Responses::STATUS_2_END
                      .sub('[L]', lab_count[:left].to_s)
                      .sub('[T]', lab_count[:total].to_s)
      end
    end

    def text_add_subject(subj)
      @result_msg += "\n*" + subj + '* -'
    end

    def percent
      user.sem_passed_percent
    end

    def count_labs_all(lab_count)
      user.subjects.each do |subj, values|
        lab_count[:total] += values.count.to_i
        next if values.count(false).zero?
        text_add_subject(subj)
        count_per_subj(lab_count, values)
      end
    end

    def count_labs_needed(lab_count)
      user.subjects.each do |subj, values|
        lab_count[:total] += lab_count[:needed] = (percent * values.count).to_i
        needed_labs = values.take(lab_count[:needed])
        next if needed_labs.count(false).zero?
        text_add_subject(subj)
        count_per_subj(lab_count, needed_labs)
      end
    end

    def count_per_subj(lab_count, labs)
      labs.each_index do |lab|
        next if labs[lab]
        lab_count[:left] += 1
        @result_msg += ' ' + (lab + 1).to_s
      end
    end

    # Fuck ABC
    def prepare_sem_text
      [
        user.sem_start_text,
        user.sem_end_text,
        user.sem_passed_percent_text,
        (user.sem_time_left / 30).to_s,
        (user.sem_time_left % 30).to_s
      ]
    end

    def sem_text
      return '' unless user.sem_defined?
      text = prepare_sem_text
      Responses::SEM_TEXT
        .sub('[START]', text[0])
        .sub('[END]', text[1])
        .sub('[PERC]', text[2])
        .sub('[ML]', prepare_sem_text[3])
        .sub('[DL]', text[4])
    end
  end
end
