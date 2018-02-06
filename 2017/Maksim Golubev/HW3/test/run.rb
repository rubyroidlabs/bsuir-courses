require_relative '../lib/telegram'

WebParser.new.save_to_redis(WebParser.new.union_gays)
Bot.new.bot_start
