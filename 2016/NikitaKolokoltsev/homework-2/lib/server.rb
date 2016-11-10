# Server
class Server < WEBrick::HTTPServlet::AbstractServlet
  def do_post(request, response)
    run_bot(request.body)
    response.status = 200
    response["Content-Type"] = "text/plain"
    response.body = "OK"
  end

  def run_bot(request)
    Bot.new.run(request)
  end

  alias do_POST do_post
end
