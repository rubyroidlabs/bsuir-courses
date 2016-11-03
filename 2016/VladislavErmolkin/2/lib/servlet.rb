require_relative 'start'
require_relative 'user'
require_relative 'semester'
require_relative 'subject'
require_relative 'status'
require_relative 'reset'
require_relative 'submit'

# Class Servlet.
class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def initialize(server, bot)
    super server
    @bot = bot
  end

  def do_POST(request, response)
    body = JSON.parse request.body.gsub('\n', ' ')
    body =  Telegram::Bot::Types::Update.new(body)
    handler body
    response.status = 200
    response.body = 'Success.'
  end

  def handler(body)
    message = body.callback_query.nil? ? body.message : body.callback_query
    text = body.callback_query.nil? ? body.message.text : body.callback_query.data
    @user = User.new(message.from.id)
    answer = action_process(text, message.from.first_name)
    button_names = Submit.new(@user, text).button_names
    if button_names.nil?
      @bot.api.send_message(chat_id: message.from.id, text: answer)
    else
      @bot.api.send_message(chat_id: message.from.id, text: answer, reply_markup: create_keyboard(button_names))
    end
  end

  def action_process(text, name)
    difficult_action = try_difficult_action text
    return difficult_action unless difficult_action.nil?
    try_ordinary_action text, name
  end

  def try_ordinary_action(text, name)
    case text
    when '/start' then Start.new(name).run
    when '/semester' then Semester.new(@user, text).run
    when '/subject' then Subject.new(@user, text).run
    when '/status' then Status.new(@user, text).run
    when '/reset' then Reset.new(@user, text).run
    when '/submit', 'I passed.' then Submit.new(@user, text).run
    else "I don't understand.\nDon't panic. You've got to know where your towel is."
    end
  end

  def try_difficult_action(text)
    return Semester.new(@user, text).run if @user.sem['__is_now?']
    return Subject.new(@user, text).run if @user.subjects['__is_now?']
    return Submit.new(@user, text).run if @user.submit['__is_now?']
  end

  def create_keyboard(names)
    buttons = names.collect { |name| Telegram::Bot::Types::InlineKeyboardButton.new(text: name.to_s, callback_data: name.to_s) }
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons)
  end
end
