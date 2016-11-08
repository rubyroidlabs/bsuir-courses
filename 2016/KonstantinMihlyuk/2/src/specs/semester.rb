require "rspec"
require_relative "../commands/semester.rb"
require_relative "../constants/answer.rb"

RSpec.describe Semester do

  user = {
    "subjects"=> {
      "mrz"=> {
        "labs_count"=> 10,
        "made_labs"=> [2, 4, 5, 6]
      },
      "ppvis"=> {
        "labs_count"=> 10,
        "labs"=> [2, 4, 5, 6]
      }
    },
    "start_date" => "01-09-2016",
    "finish_date" => "03-11-2016",
    "available_days" => "41",
    "reminders"=> [{
      "days"=> 1,
      "hour"=> 12
    }]
  }

  describe "check returned messages for semester class" do

    it "should return incorrect date message" do
      semester = Semester.new(user)
      semester.say("/start")

      expect(semester.say("-12-01-2016")).to eq(Answer::FAIL_START_LEARNING_DATE)
      expect(semester.say("32-11-2016")).to eq(Answer::FAIL_START_LEARNING_DATE)
      expect(semester.say("15-13-2016")).to eq(Answer::FAIL_START_LEARNING_DATE)
      expect(semester.say("13-10-1997")).to eq(Answer::FAIL_START_LEARNING_DATE)
      expect(semester.say("12-10-2016")).to eq(Answer::WHEN_END_TO_LEARN)
    end

    it "should return incorrect date message" do
      semester = Semester.new(user)
      semester.say("/start")

      expect(semester.say("01-09-2016")).to eq(Answer::WHEN_END_TO_LEARN)
    end

    it "should return incorrect available days message" do
      semester = Semester.new(user)
      semester.say("/start")
      semester.say("12-10-2016")

      expect(semester.say("01-09-2016")).to eq(Answer.FAIL_AVAILABLE_DAYS(user["available_days"]))
    end

    it "should return correct finish message" do
      semester = Semester.new(user)
      semester.say("/start")
      semester.say("01-09-2016")

      expect(semester.say("12-10-2016")).to eq(Answer::HOW_MANY_DAYS_YOU_HAVE(user["available_days"]))
    end
  end
end
