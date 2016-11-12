# stickers
class StickerBot < Bot
  def initialize(bot, message)
    super(bot, message)
  end

  def run
    send_sticker(Secret::MEMES_STORAGE.sample)
    nil
  end
end
