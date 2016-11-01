require_relative 'start'
require_relative 'user'
require_relative 'semester'
require_relative 'subject'
require_relative 'status'
require_relative 'reset'

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def initialize server, bot
    super server
    @bot = bot
  end

  def do_POST(request, response)
    body = JSON.parse request.body.gsub("\n", " ")
    body =  Telegram::Bot::Types::Update.new(body)
    @user = User.new(body.message.from.id)
    handler body.message
    response.status = 200
    response.body = 'Success.'
  end

  def handler(message)
    if message.nil? then nil end
    answer = action_process(message.text, message.from.first_name)
    @bot.api.send_message(chat_id: @user.id, text: answer)
  end


  def action_process(text, name)
    if @user.sem["__is_now?"]
      return Semester.new(@user, text).run
    end
    if @user.subjects["__is_now?"]
      return Subject.new(@user, text).run
    end
    case text
    when '/start' then Start.new(name).run
    when '/semester' then Semester.new(@user, text).run
    when '/subject' then Subject.new(@user, text).run
    when '/status' then Status.new(@user, text).run
    when '/reset' then Reset.new(@user, text).run
    else
      "Don't panic. You've got to know where your towel is."
    end
  end
end
