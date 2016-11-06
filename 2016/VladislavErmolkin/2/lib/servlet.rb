require_relative 'start'
require_relative 'user'
require_relative 'semester'
require_relative 'subject'
require_relative 'status'
require_relative 'reset'
require_relative 'submit'
require_relative "cancel"

COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
MONTHS = [nil, "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

# Class Servlet.
class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def initialize(server, bot)
    super server
    @bot = bot
  end

  def do_POST(request, response)
    body =  Telegram::Bot::Types::Update.new(JSON.parse request.body.gsub('\n', ' '))
    body.callback_query.nil? ? handler(body.message, true) : handler(body.callback_query, false)
    response.status = 200
    response.body = 'Success.'
  end

  # TODO -> make shorter.
  def handler(message, from_text_message)
    @user = User.new(message.from.id)
    text = from_text_message ? message.text : message.data
    return nil unless text_validation(text, from_text_message)
    answer = if !@user.sys["subjects_phase"].zero? then Subject.new(@user, text).run
             elsif !@user.sys["semester_phase"].zero? then Semester.new(@user, text).run
             elsif !@user.sys["submission_phase"].zero? then Submission.new(@user, text).run
             else answer = try_ordinary_action(text, message.from.first_name)
    end
    send_message(message.from.id, text, answer)
  end

  def text_validation(text, from_text_message)
    if text == '/cancel' && (!@user.sys["subjects_phase"].zero? || !@user.sys["semester_phase"].zero? || !@user.sys["submission_phase"].zero?)
      Cancel.new(@user, text).run
      send_message(@user.id, nil, "Successfully.")
      return false
    end
    return false if text.nil?
    return false if from_text_message && (!@user.sys["semester_phase"].zero? || !@user.sys["submission_phase"].zero?)
    return false if !from_text_message && (@user.sys["semester_phase"].zero? && @user.sys["submission_phase"].zero?)
    true
  end

  def send_message(id, text, answer)
    return if answer.nil?
    if !@user.sys["semester_phase"].zero? || !@user.sys["submission_phase"].zero?
      @bot.api.send_message(chat_id: id, text: answer, reply_markup: create_keyboard(text))
    else
      @bot.api.send_message(chat_id: id, text: answer)
    end
  end

  def try_ordinary_action(text, name)
    case text
    when '/start' then Start.new(name).run
    when '/semester' then Semester.new(@user, text).run
    when '/subject' then Subject.new(@user, text).run
    when '/status' then Status.new(@user, text).run
    when '/reset' then Reset.new(@user, text).run
    when '/submit', 'I passed.' then Submission.new(@user, text).run
    when "/cancel" then "Nothing to cancel."
    else "I don't understand.\nDon't panic. You've got to know where your towel is."
    end
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
    if !@user.sys["submission_phase"].zero?
      @user.sys["submission_phase"] == 1 ? @user.subjects.keys.each_slice(1) : @user.subjects[@user.sys["current"]].each_slice(5).to_a
    elsif !@user.sys["semester_phase"].zero?
      case @user.sys["semester_phase"]
      when 1, 4 then [[2016], [2017]].to_a
      when 2, 5 then MONTHS[1..-1].each_slice(4).to_a
      when 3, 6 then (1..days_in_month((MONTHS.index(text)).to_i)).each_slice(7).to_a
      end
    end
  end

  def days_in_month(month, year = Time.now.year)
     return 29 if month == 2 && Date.gregorian_leap?(year)
     COMMON_YEAR_DAYS_IN_MONTH[month]
  end  
end
