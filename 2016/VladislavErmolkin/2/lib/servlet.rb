require_relative 'start'
require_relative 'semester'
require_relative 'user'

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def initialize server, bot
    super server
    @bot = bot
  end

  def do_POST(request, response)
    body = JSON.parse request.body.gsub("\n", " ")
    putsmth body
    body =  Telegram::Bot::Types::Update.new(body)
    @user = User.new(body.message.from.id)
    handler body.message
    @user.save
    response.status = 200
    response.body = 'Success.'
  end

  def handler(message)
    if message.nil?
      return nil
    end
    puts 'IN HANDLER.'
    answer = action_process(message.text)
    @bot.api.send_message(chat_id: @user.id, text: answer)
  end


  def action_process(text)
    puts 'IN ACTION_PROCESS.'
    puts @user.to_hash
    if @user.sem["is_now?"]
      return semester_process(text)
    end
    case text
    when '/start' then Start.new.run
    when '/semester'
      semester_process(text)
    else
      "Don't panic. You've got to know where your towel is."
    end
  end

  def semester_process(text)
    puts 'IN SEMESTER_PROCESS.'
    sem = Semester.new(@user, text)
    result = sem.run
    puts "semester_process_now is #{@semester_process_now}."
    if result == nil 
      return 'I don\'t know this date.' 
    else 
      return result
    end
  end

end


def putsmth(smth)
  puts "============="
  p smth
  puts "============="
end