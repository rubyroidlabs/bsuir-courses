# myservlet
class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_post(request, response)
    body = JSON.parse(request.body.tr("\n", " "))
    if body["callback_query"]
      message = Telegram::Bot::Types::Update.new(body).callback_query
    elsif body["message"]
      message = Telegram::Bot::Types::Update.new(body).message
    end
    Telegram::Bot::Client.run(Secret::TOKEN) do |bot|
      handler(message, bot)
    end
    response.status = 200
  end
  alias do_POST do_post

  def handler(message, bot)
    return if message.nil?
    uid = message.from.id
    content = get_content_from_file(uid)
    user = User.new(uid, JSON(content))
    user.handler(message, bot)
  end

  def get_content_from_file(uid)
    if File.exist?("UsersData/#{uid}")
      file = File.open("UsersData/#{uid}", "r")
      content = file.read
    else
      file = File.open("UsersData/#{uid}", "w+")
      file.write("{}")
      content = "{}"
    end
    file.close
    content
  end
end
