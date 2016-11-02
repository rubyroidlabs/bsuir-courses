require_relative 'start'
require_relative 'user'
require_relative 'semester'
require_relative 'subject'
require_relative 'status'
require_relative 'reset'
require_relative 'submit'

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def initialize server, bot
    super server
    @bot = bot
  end

  def do_POST(request, response)
    body = JSON.parse request.body.gsub("\n", " ")
    body =  Telegram::Bot::Types::Update.new(body)
    handler body
    response.status = 200
    response.body = 'Success.'
  end


  def handler(body)
    message = body.callback_query.nil? ? body.message : body.callback_query
    text = body.callback_query.nil? ? body.message.text : body.callback_query.data
    putsmth message
    putsmth text
    @user = User.new(message.from.id)
    putsmth @user
    answer = action_process(text, message.from.first_name)
    putsmth answer
    button_names = Submit.new(@user, text).get_button_names
    if button_names.nil?
      @bot.api.send_message(chat_id: message.from.id, text: answer)
    else
      @bot.api.send_message(chat_id: message.from.id, text: answer, reply_markup: create_keyboard(button_names)) 
    end
  end

  def action_process(text, name)
    if @user.sem["__is_now?"]
      return Semester.new(@user, text).run
    elsif @user.subjects["__is_now?"]
      return Subject.new(@user, text).run
    elsif @user.submit["__is_now?"]
      return Submit.new(@user, text).run
    end
    case text
    when '/start' then Start.new(name).run
    when '/semester' then Semester.new(@user, text).run
    when '/subject' then Subject.new(@user, text).run
    when '/status' then Status.new(@user, text).run
    when '/reset' then Reset.new(@user, text).run
    when '/submit' then Submit.new(@user, text).run
    else
      "Don't panic. You've got to know where your towel is."
    end
  end

  def create_keyboard(names)
    buttons = names.collect { |name| Telegram::Bot::Types::InlineKeyboardButton.new(text:"#{name}", callback_data:"#{name}") }
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard:buttons)
  end
end


def putsmth(text)
  puts ''
  p '=============================='
  p text
  p '==============================='
  puts ''
end