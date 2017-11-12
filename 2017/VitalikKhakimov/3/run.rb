require './bot'
require_relative 'parser'
require_relative 'translator'

parse = Parser.new
parse.info
bot = TelegramBot.new('494226655:AAFndtN3Kc1u31gjT9xyCeisvhbMPU_N-TE')
bot.start
