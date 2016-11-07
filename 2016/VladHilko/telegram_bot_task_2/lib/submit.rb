# This class will help you close your labs
class Submit < Base
  def send_messages
    ask_about_subject('Что сдавал?')
    ask_about_lab_number('Какую лабу сдал?')
    telegram_send_message('ok')
  end

  def ask_about_subject(question)
    hash_subject = @redis.hgetall("#{@user_id}-subject")
    actual_key = hash_subject.keys.reject { |k| @redis.smembers("#{@user_id}-subject-#{k.downcase}").empty? }
    answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: actual_key, one_time_keyboard: true)
    telegram_send_message(question, answers)
    take_new_answer
  end

  def ask_about_lab_number(question)
    selected_subject = @messages_array.last
    subject_name_in_redis = "#{@user_id}-subject-#{selected_subject.downcase}"

    # if @redis.smembers(subject_name_in_redis).empty?
    #   telegram_send_message('not subject')
    #   return
    # end

    answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: num_to_sequence(@redis.smembers(subject_name_in_redis)), one_time_keyboard: true)

    telegram_send_message(question, answers)
    take_new_answer
    @redis.srem(subject_name_in_redis, @messages_array.last)
  end
end
