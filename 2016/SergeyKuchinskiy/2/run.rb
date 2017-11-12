require "telegram/bot"
require "webrick"
require "json"
require "require_all"
require "date"
require_all "lib"

server = WEBrick::HTTPServer.new(Port: 3333)
server.mount "/", MyServlet

trap("INT") do
  server.shutdown
end

server.start
