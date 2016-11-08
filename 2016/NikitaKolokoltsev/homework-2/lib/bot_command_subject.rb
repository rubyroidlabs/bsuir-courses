# /subject
class BotCommandSubject < BotCommand
  attr_accessor :message

  ADD_SUBJECT = "
  How is subject called?
  ".freeze

  ADD_LABS_COUNT = "
  How many labs you should pass?
  ".freeze

  OK = "OK".freeze

  LABS_COUNT_REGEXP = /^[0-9]+$/

  def initialize(update)
    @message = update.message
  end

  def called?
    calling_commands = %w(subject_input labs_count_input)
    user = database_load(@message.chat.id)
    @message.text =~ %r{/subject} || calling_commands.include?(user[:previous_command].split("/")[0])
  rescue
    false
  end

  def show_error_message(error)
    send_message(chat_id: @message.chat.id, text: LABS_COUNT_FORMAT_ERROR) if error.class == LabsCountFormatError
    send_message(chat_id: @message.chat.id, text: SUBJECT_FORMAT_ERROR) if error.class == SubjectFormatError
  end

  def remember_command(user)
    send_message(chat_id: @message.chat.id, text: ADD_SUBJECT)
    user[:previous_command] = "subject_input"
  end

  def add_subject(user)
    subject = @message.text
    fail SubjectFormatError if subject[0] == "/"
    add_to_subjects(user, subject)
    user[:previous_command] = "labs_count_input/#{subject}"
    send_message(chat_id: @message.chat.id, text: ADD_LABS_COUNT)
  end

  def add_to_subjects(user, subject)
    if user[:subjects].nil?
      user[:subjects] = Hash[subject.to_sym, []]
    else
      user[:subjects].merge!(Hash[subject.to_sym, []])
    end
  end

  def add_labs_count(user)
    labs_count = @message.text
    fail LabsCountFormatError unless labs_count =~ LABS_COUNT_REGEXP && labs_count.to_i.positive?
    subject = user[:previous_command].split("/")[1].to_sym
    fill_labs(user, subject, labs_count)
    user[:previous_command] = nil
    send_message(chat_id: @message.chat.id, text: OK)
  end

  def fill_labs(user, subject, labs_count)
    user[:subjects][subject] = Array.new(labs_count.to_i) { |l| l + 1 }
  end

  def add_subject_with_labs(user)
    if user[:previous_command].nil?
      remember_command(user)
    elsif user[:previous_command] == "subject_input"
      add_subject(user)
    elsif user[:previous_command].include?("labs_count_input")
      add_labs_count(user)
    end
  end

  def perform
    user = database_load(@message.chat.id)
    add_subject_with_labs(user)
    database_save(@message.chat.id, user)
  rescue LabsCountFormatError, SubjectFormatError => error
    show_error_message(error)
    user[:previous_command] = "subject_input"
    send_message(chat_id: @message.chat.id, text: ADD_SUBJECT)
    database_save(@message.chat.id, user)
  end
end
