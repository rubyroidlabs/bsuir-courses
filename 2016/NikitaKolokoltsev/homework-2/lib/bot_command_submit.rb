# /submit
class BotCommandSubmit < BotCommand
  def initialize(update)
    @message = update.message || update.callback_query
  end

  def called?
    user = load_user
    initialize_command(user) || continue_command(user)
  rescue
    false
  end

  def initialize_command(user)
    calling_commands = %w(/submit сдал сдала сдавал сдавала сдано)
    (callback? || calling_commands.include?(@message.text)) && user[:previous_command].nil?
  end

  def callback?
    @message.is_a?(Telegram::Bot::Types::CallbackQuery)
  end

  def continue_command(user)
    calling_commands = %w(show_subjects show_subject_labs)
    calling_commands.include?(user[:previous_command])
  end

  def delete_lab(user, subject, lab)
    user[:previous_command] = nil
    user[:subjects][subject].delete(lab)
    send_message(chat_id: @message.message.chat.id, text: OK)
  end

  def show_subject_labs(user, subject)
    user[:previous_command] = "show_subject_labs"
    labs = []
    return if all_labs_done?(user, subject)
    user[:subjects][subject].each do |v|
      labs << Telegram::Bot::Types::InlineKeyboardButton.new(text: v.to_s, callback_data: "#{subject}-#{v}")
    end
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: labs)
    send_message(chat_id: @message.message.chat.id, text: CHOOSE_LAB, reply_markup: markup)
  end

  def all_labs_done?(user, subject)
    if user[:subjects][subject].empty?
      send_message(chat_id: @message.message.chat.id, text: ALL_LABS_DONE)
      return true
    end
    false
  end

  def show_subjects(user)
    user[:previous_command] = "show_subjects"
    subjects = []
    user[:subjects].keys.each do |k|
      subjects << Telegram::Bot::Types::InlineKeyboardButton.new(text: k.to_s, callback_data: k.to_s)
    end
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: subjects)
    send_message(chat_id: @message.chat.id, text: CHOOSE_SUBJECT, reply_markup: markup)
  end

  def process_callback(user, message)
    if message.data.split("-")[1] =~ LABS_COUNT_REGEXP
      parse_callback_and_delete_lab(user, message)
    else
      subject = message.data.to_sym
      show_subject_labs(user, subject)
    end
  end

  def parse_callback_and_delete_lab(user, message)
    subject = message.data.split("-")[0].to_sym
    lab = message.data.split("-")[1].to_i
    delete_lab(user, subject, lab)
  end

  def subjects_added?(user)
    if user[:subjects].nil?
      send_message(chat_id: @message.chat.id, text: NO_SUBJECTS)
      return false
    end
    true
  end

  def load_user
    database_load(@message.chat.id)
  rescue
    database_load(@message.message.chat.id)
  end

  def perform
    user = load_user
    return unless subjects_added?(user)
    case @message
    when Telegram::Bot::Types::Message
      show_subjects(user)
      database_save(@message.chat.id, user)
    when Telegram::Bot::Types::CallbackQuery
      process_callback(user, @message)
      database_save(@message.message.chat.id, user)
    end
  end
end
