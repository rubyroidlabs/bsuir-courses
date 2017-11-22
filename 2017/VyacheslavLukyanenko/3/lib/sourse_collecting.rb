require './lib/parser'
require './lib/clever_parser'

class SourceCollecting
  attr_reader :message
  attr_reader :bot
  attr_writer :parse_agent

  def initialize(message, bot)
    @bot = bot
    @message = message
    @first_parse_agent = ParsePages.new(message, bot)
    @second_parse_agent = CleverParser.new(message, bot)
  end

  def imdb_parse
    @first_parse_agent.make_data_from_imdb
    @first_parse_agent.get_data_from_imdb(message)
  end

  def newnow_parse
    @first_parse_agent.make_data_from_newnow
    @first_parse_agent.get_data_from_newnow(message)
  end

  def clever_parse
    @second_parse_agent.make_data_from_clever
    @second_parse_agent.get_data_from_clever(message)
  end
end
