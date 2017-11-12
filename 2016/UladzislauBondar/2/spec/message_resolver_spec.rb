require "redis"
require_relative "../libs/message_resolver"
require_relative "../libs/start"

describe MessageResolver do
  before do
    @message = {}
    @message[:from] = {}
    @message[:from][:id] = 1
  end

  describe "#resolve_command" do
    it "given /start" do
      @message[:text] = "/start"
      message_resolver = MessageResolver.new(@message)

      expect(message_resolver.send(:resolve_command)).to eq(Command::Start)
    end

    it "given nil" do
      @message[:text] = nil
      message_resolver = MessageResolver.new(@message)

      expect(message_resolver.send(:resolve_command)).to eq(nil)
    end
  end

  describe "#users" do
    it "is hash" do
      @message[:text] = "text"
      message_resolver = MessageResolver.new(@message)

      expect(message_resolver.send(:users)).to be_a_kind_of(Array)
    end
  end
end
