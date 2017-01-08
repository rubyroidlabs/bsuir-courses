require 'telegram/bot'
require 'require_all'
require_all 'lib'

def form_message(user_id)
  user = User.new(user_id)
  return nil unless check_sem?(user)
  return nil unless check_subjects?(user)
  @result_msg = ''
  lab_count_needed = { total: 0, left: 0, needed: 0 }
  count_labs_needed(user, lab_count_needed)
  Responses::REMIND + form_message_needed(lab_count_needed)
end

def check_sem?(user)
  !user.sem_defined? || !user.sem_now? ? false : true
end

def check_subjects?(user)
  user.subjects? ? true : false
end

def count_labs_needed(user, lab_count)
  user.subjects.each do |subj, values|
    lab_count[:total] += lab_count[:needed] = (user.sem_passed_percent * values.count).to_i
    needed_labs = values.take(lab_count[:needed])
    next if needed_labs.count(false).zero?
    text_add_subject(subj)
    count_per_subj(lab_count, needed_labs)
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

def text_add_subject(subj)
  @result_msg += "\n*" + subj + '* -'
end

def count_per_subj(lab_count, labs)
  labs.each_index do |lab|
    next if labs[lab]
    lab_count[:left] += 1
    @result_msg += ' ' + (lab + 1).to_s
  end
end

def send_message(chat_id, text)
  @bot.api.send_message(
    chat_id: chat_id,
    text: text,
    parse_mode: 'Markdown'
  )
end

users_reminded = 0
@bot = Telegram::Bot::Client.new(Secret::TELEGRAM_TOKEN)
time = Time.now.getlocal('+03:00')
reminders = Reminders.new
users = reminders.remind_ids(time)
users.each do |user_id|
  msg = form_message(user_id)
  next if msg.nil?
  begin
    send_message(user_id.to_i, msg)
    users_reminded += 1
  rescue Telegram::Bot::Exceptions::ResponseError
    puts 'User blocked me =('
    reminders.delete_user(user_id)
  end
end
puts "Reminded to #{users_reminded} people"
