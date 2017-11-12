require 'telegram/bot'
require 'open-uri'
require 'nokogiri'

url = 'http://www.imdb.com/list/ls072706884/?start=1&view=detail&sort=listorian:asc'
html = open(url)
doc = Nokogiri::HTML(html)
token = '453506418:AAGlJGL0yduKIwwrjcxRWr92fBq8z5qPe0U'

celebrity_names = []
doc.css('.info').each do |b|
  name = b.css('b').text
  celebrity_names<<name

end




Telegram::Bot::Client.run(token) do |bot|


  bot.listen do |message|
    case message.text
      when '/start'
        bot.api.sendMessage(chat_id: message.chat.id, text: "Please enter the full name of the star to see if he or she made the caming out")
      else
        name = celebrity_names.detect { |celebrity| celebrity == message.text }
        if name.nil?
          bot.api.sendMessage(chat_id: message.chat.id, text: "No")
        else
          bot.api.sendMessage(chat_id: message.chat.id, text: "Yes")
        end
    end
  end
end