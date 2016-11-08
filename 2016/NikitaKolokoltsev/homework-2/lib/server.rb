# WEBrick server for webhooks
class Server < WEBrick::HTTPServlet::AbstractServlet
  def do_POST(request, response)
    run_bot(request.body)
    response.status = 200
    response["Content-Type"] = "text/plain"
    response.body = "OK"
  end

  def run_bot(request)
    redis = Redis.new
    token = "288795431:AAEmmmRKg0W5tEP9qGvO_DTJtF69OIP-lvc"
    Telegram::Bot::Client.run(token) do |bot|
      Bot.new(bot, redis)
      bot_command_handler = BotCommandHandler.new
      bot.listen(request) do |update|
        bot_command_handler.process(update)
      end
    end
  end
end
