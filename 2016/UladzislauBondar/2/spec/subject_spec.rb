require "telegram/bot"
require "redis"
require_relative "../libs/subject"
include Command

describe Subject do
  before do
    @message = {}
    @message[:from] = {}
    @message[:from][:id] = 1
  end

  describe "#positive_number?" do
    it "given not number" do
      @message[:text] = "text"
      @subject = Subject.new(@message)

      expect(@subject.send(:positive_number?)).not_to eq(true)
    end
  end
end
