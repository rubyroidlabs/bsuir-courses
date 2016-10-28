class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_POST (request, response)
    body = JSON.parse(request.body.gsub("\n", " "))
    body =  Telegram::Bot::Types::Update.new(body)
    message = body.message
    puts "message= #{message}"
    handler(message)
    response.status = 200
    response.body = 'KEK'
  end
 
 
  def handler(message)
    if message.nil?
      return
    end
 
    puts "message: #{message.text}"
    uid = message.from.id
 
    $bot.api.send_message(chat_id: message.from.id, text: "11111111111")
  end
end