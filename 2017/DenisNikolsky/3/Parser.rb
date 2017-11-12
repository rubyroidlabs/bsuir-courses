class Parser
  def initialize
    @agent = Mechanize.new
    @agent.user_agent_alias = 'Mac Safari'
  end
end
