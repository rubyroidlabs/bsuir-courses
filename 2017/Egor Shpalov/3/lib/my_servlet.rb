class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def initialize(server, bot, list)
    @server = server
    @bot = bot
    @list = list
  end

  def do_post(request, response)
    temp = JSON.parse(request.body.gsub('\n', ' '))
    body = Telegram::Bot::Types::Update.new(temp)
    if body.callback_query.nil?
      handler(body.message, true)
    else
      handler(body.callback_query, false)
    end
    response.status = 200
    response.body = 'Success.'
  end

  alias do_POST do_post

  def handler(message, from_text_message)
    text = from_text_message ? message.text : message.data
    return nil unless text_validation(text)
    answer(message, text)
  end

  def text_validation(text)
    return true if text == '/cancel'
    return false if text.nil?
    true
  end

  def answer(message, text)
    case text
    when '/start'
      Start.new(@bot, message).menu
    else
      Result.new(@bot, message).check(text, @list)
    end
  end
end
