# Class for working with reminders
class Reminders
  def initialize
    @ds = DataStorage.instance
    @reminders = @ds.reminders? ? @ds.reminders : create_reminders
  end

  private

  attr_accessor :reminders

  def save(saved_reminders = @reminders)
    @ds.reminders = saved_reminders
    saved_reminders
  end

  def create_reminders
    new_reminders = {}
    save(new_reminders)
  end

  def user?(user_id)
    !reminders[user_id].nil?
  end

  def get_user(user_id)
    unless user?(user_id)
      reminders[user_id] = {}
      save
    end
    reminders[user_id]
  end

  def set_user(user_id, rems)
    reminders[user_id] = rems.sort.to_h
    save
  end

  def parse_time(time)
    time.split(':').map(&:to_i)
  end

  def user_hour?(rems, day, hour)
    day = day.to_s
    rems[day] && !rems[day].select { |i| i[0] == hour.to_i }.flatten.empty?
  end

  def user_remind?(rems, day, hour)
    user_hour?(rems, day, hour) || user_hour?(rems, '0', hour) ||
      if (1..5).cover?(day.to_i)
        user_hour?(rems, '8', hour)
      else
        user_hour?(rems, '9', hour)
      end
  end

  def form_line_list_text(day, time)
    "#{Responses.const_get("REMINDER_DAY_#{day}")} в "\
      "#{time[0]}:#{time[1].to_s.rjust(2, '0')}\n"
  end

  def check_cover?(user_rems, wday)
    user_rems[wday] || user_rems['0'] ||
      if (1..5).cover?(wday.to_i)
        user_rems['8']
      else
        user_rems['9']
      end
  end

  public

  def list_text(user_id)
    msg = ''
    rems = get_reminders(user_id)
    rems.each do |day, hours|
      hours.each do |time|
        msg += '*' + form_line_list_text(day, time) + '*'
      end
    end
    msg.empty? ? Responses::REMINDER_NO : Responses::REMINDER_STAT + msg
  end

  def add_reminder(user_id, day, time)
    day = day.to_s
    user_id = user_id.to_s
    user_rems = get_user(user_id)
    user_rems[day] = [] if user_rems[day].nil?
    parsed = parse_time(time)

    return false if user_rems[day].include?(parsed)
    user_rems[day].push(parsed).sort!
    set_user(user_id, user_rems)
    true
  end

  def delete_reminder(user_id, day, ind)
    day = day.to_s
    user_id = user_id.to_s
    user_rems = get_user(user_id)
    return nil if user_rems[day].nil?
    deleted = user_rems[day].delete_at(ind.to_i)
    user_rems.delete(day) if user_rems[day].empty?
    set_user(user_id, user_rems)
    delete_user(user_id) if user_rems.empty?
    deleted
  end

  def delete_user(user_id)
    reminders.delete(user_id.to_s)
    save
  end

  def get_reminders(user_id)
    user_id = user_id.to_s
    get_user(user_id)
  end

  def user_empty?(user_id)
    get_reminders(user_id).empty?
  end

  def remind_ids(time)
    day = time.wday.to_s
    hour = time.hour
    result = []
    reminders.each do |user_id, user_rems|
      next unless check_cover?(user_rems, day)
      result.push(user_id) if user_remind?(user_rems, day, hour)
    end
    result
  end
end
