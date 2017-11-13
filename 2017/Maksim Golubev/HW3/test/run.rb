require_relative '../lib/telegram'

WebParser.new.save_to_redis(WebParser.new.union_gays)
Bot_engine.new.bot_start
