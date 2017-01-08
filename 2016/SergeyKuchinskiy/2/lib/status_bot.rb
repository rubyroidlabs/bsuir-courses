# class for status command logic
class StatusBot < Bot
  def initialize(bot, message, subjects, semester)
    super(bot, message)
    @subjects = subjects
    @semester = semester
  end

  def run
    return nil unless can_calculate
    coeff = ratio_of_elapsed_to_all
    answer = list_of_statuses([], coeff)
    send_text_message(answer.join("\n"))
    nil
  end

  def ratio_of_elapsed_to_all
    elapsed = DateTime.now - DateTime.parse(@semester["start"])
    all = DateTime.parse(@semester["finish"]) - DateTime.parse(@semester["start"])
    ratio = (elapsed / all)
    ratio.to_f
  end

  def list_of_statuses(answer, coeff)
    @subjects.keys.each do |key|
      difference = diff_betw_necessary_and_real(coeff, key)
      if difference.negative?
        answer.push("#{key}:  you had to do #{-difference} lab(s) more to this time")
      else
        answer.push("#{key}:  everything is OK!")
      end
    end
    answer
  end

  def diff_betw_necessary_and_real(coeff, key)
    difference = (1 - coeff) * @subjects[key]["count"] - @subjects[key]["list"].size
    difference.to_i
  end

  def can_calculate
    return false if empty_subject? || empty_semester? || semester_has_ended? || semester_not_started?
    true
  end

  def semester_has_ended?
    return false if (DateTime.now - DateTime.parse(@semester["finish"])).negative?
    send_text_message("semester has ended")
    true
  end

  def semester_not_started?
    return false if (DateTime.now - DateTime.parse(@semester["start"])).positive?
    send_text_message("semester has not started yet")
    true
  end

  def empty_subject?
    return false if @subjects != {}
    send_text_message("First of all, you should fill the /subject")
    true
  end

  def empty_semester?
    return false if @semester != {}
    send_text_message("First of all, you should fill the /semester")
    true
  end
end
