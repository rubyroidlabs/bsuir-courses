# This class inludes your subject and labs count
class Subject < Base
  def send_messages
    ask_about_studying_subject("Какой предмет учим?")
    ask_about_labs_count("Сколько лаб надо сдать?")

    messages_array.shift
    subject_name = @messages_array.first
    subject_labs_count = @messages_array.last
    user_id = @user_id

    @redis.hmset("#{user_id}-subject", subject_name, subject_labs_count)
    @redis.sadd("#{user_id}-subject-#{subject_name.downcase}", num_to_str_sequence(subject_labs_count))

    telegram_send_message("Ок")
  end

  def ask_about_studying_subject(question)
    telegram_send_message(question)
    take_new_answer
  end

  def ask_about_labs_count(question)
    telegram_send_message(question)
    take_new_answer

    until messages_array.last =~ /\A[-+]?\d*\.?\d+\z/
      telegram_send_message("Введи число лаб пожалуйста ... ")
      take_new_answer
    end
  end
end
