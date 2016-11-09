require_relative "../config"
redis = Redis.new(REDIS_HOST)
Telegram::Bot::Client.run(BOT_TOKEN) do |bot|
  bot.listen do |message|
    semester = Semester.new(bot, message, redis)
    RSpec.describe Semester do
      describe "#data_valid?" do
        it "returns true for 01-01-2016" do
          expect(semester.data_valid?("01-01-2016")).to be true
        end
        it "returns false for 0r-01-2016" do
          expect(semester.data_valid?("0r-01-2016")).to be false
        end
        it "returns false for 0-01-2016" do
          expect(semester.data_valid?("0-01-2016")).to be false
        end
        it "returns false for 0.01.2016" do
          expect(semester.data_valid?("0.01.2016")).to be false
        end
        it "returns false for 01012016" do
          expect(semester.data_valid?("01012016")).to be false
        end
        it "returns false for 01 12 2016" do
          expect(semester.data_valid?("0 01 2016")).to be false
        end
      end
    end
    break
  end
end
