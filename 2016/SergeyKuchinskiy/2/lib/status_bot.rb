# class for status command logic
class StatusBot < Bot
  def initialize(bot, message)
    super(bot, message)
  end

  def run(subjects, semester)
    return nil if !can_calculate(subjects, semester)

    coeff = ((DateTime.now - DateTime.parse(semester["start"])) /
      (DateTime.parse(semester["finish"]) - DateTime.parse(semester["start"]))).to_f
    answer = []
    subjects.keys.each do |key|
      difference = (1 - coeff) * subjects[key]["count"] - subjects[key]["list"].size
      difference = difference.to_i
      if difference < 0
        answer.push("#{key}:  you had to do #{-difference} lab(s) more to this time")
      else
        answer.push("#{key}:  everything is OK!")
      end
    end
    send_text_message(answer.join("\n"))
    nil
  end

  def can_calculate(subjects, semester)
    correct = false
    if subjects == {}
      send_text_message("First of all, you should fill the /subject")
    elsif semester == {}
      send_text_message("First of all, you should fill the /semester")
    elsif DateTime.now - DateTime.parse(semester["start"]) < 0
      send_text_message("semester has not started yet")
    elsif DateTime.now - DateTime.parse(semester["finish"]) > 0
      send_text_message("semester has ended")
    else
      correct = true
    end
    correct
  end
end
