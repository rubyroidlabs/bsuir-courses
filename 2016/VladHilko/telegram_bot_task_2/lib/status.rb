# This class will show your current status(numbers of labs)
class Status < Base
  def send_messages
    subject_name = @redis.hgetall("#{@user_id}-subject").keys
    if @redis.keys("#{@user_id}-subject").empty?
      telegram_send_message('У тебя сейчас нет долгов.')
    elsif @redis.hgetall("#{@user_id}-date")['end'].nil?
      telegram_send_message('Введи интервал семестра /semester')
    else
      telegram_send_message('К этому времени тебе осталось сдать:')
      output_labs(subject_name)
    end
  end

  def date_difference_percent(date1, date2)
    second_in_day = 3600 * 24
    main_diff = ((date2 - date1) / second_in_day).to_i
    time_now = Time.now
    if date2 >= time_now
      diff_now_to_end = ((date2 - time_now) / second_in_day).to_f
      100 - ((diff_now_to_end / main_diff) * 100).to_i
    else
      telegram_send_message('Информация не актуальна.')
    end
  end

  def percent_elements(arr, percent)
    arr.take((arr.size * percent / 100.0).ceil)
  end

  def return_percent
    user_id = @user_id
    date1 = Time.parse(@redis.hgetall("#{user_id}-date")['begin'])
    date2 = Time.parse(@redis.hgetall("#{user_id}-date")['end'])
    date_difference_percent(date1, date2)
  end

  def output_labs(subject_name)
    labs_count_arr = []
    percent_labs = return_percent
    subject_name.each do |subj|
      redis_subject_set = @redis.smembers("#{@user_id}-subject-#{subj.downcase}")
      actual_arr = percent_elements(redis_subject_set, percent_labs)
      labs_count_arr << redis_subject_set.count
      text = actual_arr.join(' ')
      telegram_send_message("#{subj}: #{text} - лабы") unless text.empty?
    end
    output_labs_count(labs_count_arr)
  end

  def output_labs_count(labs_count_arr)
    not_submited_labs_count = labs_count_arr.inject(:+)
    all_labs_count = @redis.hgetall("#{@user_id}-subject").values.map(&:to_i).inject(:+)
    telegram_send_message("Осталось сдать #{not_submited_labs_count} из #{all_labs_count} - лаб")
  end
end
