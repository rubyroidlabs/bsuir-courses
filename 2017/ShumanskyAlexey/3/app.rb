require_relative 'config.rb'

f = File.read('parsers/data.json')
data = JSON.parse(f)

result = []

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      Start.new(bot, message).send_mess
    when '/status'
      Status.new(bot, message, data).send_mess
    when 'да', 'Да', 'yes', 'Уеs'
      Yes.new(bot, message, data, result).send_mess
    when 'нет', 'Нет', 'no', 'No'
      No.new(bot, message, result).send_mess
    else
      main = Main.new(bot, message, data)
      res = main.make_mess
      result << res
      main.send_mess(res)
    end
  end
end
