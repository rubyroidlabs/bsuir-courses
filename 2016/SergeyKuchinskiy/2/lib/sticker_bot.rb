# stickers
class StickerBot < Bot
  def initialize(bot, message)
    super(bot, message)
  end

  def run
    memes_storage = [
      "BQADAgADTQADyJsDAAG6DcSDcxpKBAI",
      "BQADBAADHQADmDVxAh2h6gc7L-sLAg0",
      "BQADAgADWgcAAlOx9wOIad-ZBUtESwI",
      "BQADAgADDgADkWgMAAF4a15udbXbSwI",
      "BQADAgADjwoAAkKvaQABcCR4M8jC_PoC",
      "BQADAgADZQEAAhmGAwAB3E7zVVHpeeAC",
      "BQADBAADggEAAjW7NgAB7jdiMJ9w8isC",
      "BQADBAADyAEAAiSFLwABhUXdgKkj7e8C",
      "BQADAgADmQUAAlOx9wPotWvV-ywlcgI",
      "BQADBAADQgQAApv7sgABWYuJKMxCV-QC",
      "BQADAgADVgAD1jUSAAE6fz9XsgABy1wC",
      "BQADAQADVgADiXcpBPIctXEFyVoeAg",
      "BQADAgADEwAD8IE4B_sJAz0pTvTBAg",
      "BQADAgADuwMAAjq5FQLpT_o8u1zbKgI",
      "BQADAgAD9gADyce4ClKlgMQWPj0BAg",
      "BQADBQADDAEAAukKyANFGtSvd3H9ngI",
      "BQADAgADTgADmS9LChDwnLoeVdnUAg"
    ]
    send_sticker(memes_storage.sample)
    nil
  end
end
