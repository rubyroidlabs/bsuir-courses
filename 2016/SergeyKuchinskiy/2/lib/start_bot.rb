# start
class StartBot < Bot
  def initialize(bot, message)
    super(bot, message)
  end

  def run
    send_text_message("Hello, #{@message.from.first_name}\n"\
    "/start\t\tshow all commands\n"\
    "/semester\t\tset begin and end of semester\n"\
    "/subject\t\tadd a subject and count of labs\n"\
    "/status\t\tshows you list of labs that you should do\n"\
    "/reset\t\treset your data\n"\
    "/submit\t\twhen you pass a lab \n"\
    "/memes\t\t\n"\
    "/give_me_memes")
    nil
  end
end
