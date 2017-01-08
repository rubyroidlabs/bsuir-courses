# memes
class MemesBot < Bot
  def initialize(bot, message)
    super(bot, message)
  end

  def run
    kb = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: "двач", url: "https://2ch.hk/b/"),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: "9gag", url: "http://9gag.com/"),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: "4chan", url: "http://www.4chan.org/"),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: "joyreactor", url: "http://joyreactor.com/")
    ]
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
    send_markup_message("Make a choice", markup)
    nil
  end
end
