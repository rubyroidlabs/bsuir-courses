require_relative "../config"
redis = Redis.new(REDIS_HOST)
Telegram::Bot::Client.run(BOT_TOKEN) do |bot|
  bot.listen do |message|
    semester = Semester.new(bot, message, redis)
    RSpec.describe Semester do
      describe "#data_valid?" do
        it "returns true for 01-01-2016" do
          expect(semester.data_valid?("01-01-2016", false)).to be true
        end
        it "returns false for 0r-01-2016" do
          expect(semester.data_valid?("0r-01-2016", false)).to be false
        end
        it "returns false for 0-01-2016" do
          expect(semester.data_valid?("0-01-2016", false)).to be false
        end
        it "returns false for 0.01.2016" do
          expect(semester.data_valid?("0.01.2016", false)).to be false
        end
        it "returns false for 01012016" do
          expect(semester.data_valid?("01012016", false)).to be false
        end
        it "returns false for 01 12 2016" do
          expect(semester.data_valid?("01 12 2016", false)).to be false
        end
      end
      describe "#date_border_check" do
        it "return true for vaild dates" do
          start_date = "01-09-2016"
          end_date = "15-12-2016"
          expect(semester.date_border_check(end_date, start_date)).to be true
        end
        it "return false for invalid dates" do
          start_date = "01-09-2016"
          end_date = "01-08-2016"
          expect(semester.date_border_check(end_date, start_date)).to be false
        end
        it "return false for invalid dates" do
          start_date = "01-09-2017"
          end_date = "01-10-2017"
          expect(semester.date_border_check(end_date, start_date)).to be false
        end
        it "return false for invalid dates" do
          start_date = "01-09-2016"
          end_date = "02-09-2016"
          expect(semester.date_border_check(end_date, start_date)).to be false
        end
      end
    end
    break
  end
end
