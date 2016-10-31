require_relative 'start'
require_relative 'semester'
DATE_REGEX = /^\d{2,4}-\d{1,2}-\d{1,2}$/

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def initialize server, bot
    super server
    @bot = bot
    @semester_process_now = false
  end

  def do_POST(request, response)
    body = JSON.parse request.body.gsub("\n", " ")
    putsmth body
    body =  Telegram::Bot::Types::Update.new(body)
    handler body.message 
    response.status = 200
    response.body = 'Success.'
  end
 
 
  def handler(message)
    if message.nil? then return
    answer = case @semester_process_now
    when true then semester_process(message)
    when false then action_process(message)
    end
    @bot.api.send_message(chat_id: message.from.id, text: answer)
  end

  def action_process(message)
    case message.text
    when '/start' then Start.new.run
    when '/semester'
      @semester_process_now = true
      Semester.new(message.from.id, message.text).run
    else
      "Don't panic. You've got to know where your towel is."
    end
  end

  def semester_process(message)
    if is_date? message.text do
      sem = Semester.new(message.from.id, message.text)
      result = sem.run
      @semester_process_now = false if sem.user.sem_phase == 0
      return result
    else 'I don\'t know this date.'
    end
  end

  def is_date?(string)
    if string.match(DATE_REGEX) then true
    else false
    end
  end
end


def putsmth(smth)
  puts "============="
  p smth
  puts "============="
end