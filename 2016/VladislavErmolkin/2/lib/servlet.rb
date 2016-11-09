require_relative "start"
require_relative "user"
require_relative "semester"
require_relative "subject"
require_relative "status"
require_relative "reset"
require_relative "submit"
require_relative "cancel"

COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31].freeze
MONTHS = [nil, "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"].freeze
ACTIVITIES = { "/start" => Start, "/semester" => Semester, "/subject" => Subject, "/status" => Status, "/reset" => Reset, "/submit" => Submission, "I passed." => Submission }.freeze

# Class Servlet.
class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def initialize(server, bot)
    super(server)
    @bot = bot
  end

  def do_post(request, response)
    body = Telegram::Bot::Types::Update.new(JSON.parse(request.body.gsub('\n', " ")))
    body.callback_query.nil? ? handler(body.message, true) : handler(body.callback_query, false)
    response.status = 200
    response.body = "Success."
  end

  alias do_POST do_post

  def handler(message, from_text_message)
    @user = User.new(message.from.id)
    text = from_text_message ? message.text : message.data
    return nil unless text_validation(text, from_text_message)
    send_message(message.from.id, text, answer(message, text))
  end

  def answer(message, text)
    return cancel(text) if text == "/cancel"
    ans = try_continue_difficult_action(text)
    ans.nil? ? try_ordinary_action(text, message.from.first_name) : ans
  end

  def run_action(cl, text)
    cl.new(@user, text).run
  end

  def try_continue_difficult_action(text)
    if @user.sys["subjects_phase"].positive? then run_action(Subject, text)
    elsif @user.sys["semester_phase"].positive? then run_action(Semester, text)
    elsif @user.sys["submission_phase"].positive? then run_action(Submission, text)
    end
  end

  def text_validation(text, from_text_message)
    return true if text == "/cancel"
    return false if text.nil?
    if from_text_message
      return false if any_button_action_active?
    elsif button_actions_inactive?
      return false
    end
    true
  end

  def cancel(text)
    if @user.sys["subjects_phase"].positive? || any_button_action_active?
      Cancel.new(@user, text).run
      "Successfully."
    else
      "Nothing to cancel."
    end
  end

  def any_button_action_active?
    @user.sys["semester_phase"].positive? || @user.sys["submission_phase"].positive?
  end

  def button_actions_inactive?
    @user.sys["semester_phase"].zero? && @user.sys["submission_phase"].zero?
  end

  def send_message(id, text, answer)
    return if answer.nil?
    if any_button_action_active? then @bot.api.send_message(chat_id: id, text: answer, reply_markup: create_keyboard(text))
    else @bot.api.send_message(chat_id: id, text: answer)
    end
  end

  def try_ordinary_action(text, name)
    return Start.new(@user, name).run if text == "/start"
    return run_action(ACTIVITIES[text], text) if ACTIVITIES.include? text
    "I don't understand.\nDon't panic. You've got to know where your towel is."
  end

  def create_keyboard(text)
    buttons = button_names(text).map do |row|
      row.map do |name|
        Telegram::Bot::Types::InlineKeyboardButton.new(text: name.to_s, callback_data: name.to_s)
      end
    end
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons)
  end

  def button_names(text)
    return buttons_for_submission if @user.sys["submission_phase"].positive?
    return buttons_for_semester(text) if @user.sys["semester_phase"].positive?
  end

  def buttons_for_submission
    if @user.sys["submission_phase"] == 1 then @user.subjects.keys.each_slice(1).to_a
    else @user.subjects[@user.sys["current"]].each_slice(5)
    end
  end

  def buttons_for_semester(text)
    case @user.sys["semester_phase"]
    when 1, 4 then [[2016], [2017]]
    when 2, 5 then MONTHS[1..-1].each_slice(4).to_a
    when 3, 6 then (1..days_in_month(text)).each_slice(7).to_a
    end
  end

  def days_in_month(month_string, year = Time.now.year)
    month = (MONTHS.index month_string).to_i
    return 29 if month == 2 && Date.gregorian_leap?(year)
    COMMON_YEAR_DAYS_IN_MONTH[month]
  end
end
