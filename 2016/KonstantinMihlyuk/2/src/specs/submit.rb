require 'rspec'
require_relative "../commands/submit.rb"
require_relative "../constants/answer.rb"

RSpec.describe Submit do

  user = {
    'subjects'=> {
      'mrz'=> {
        'labs_count'=> 10,
        'made_labs'=> [2, 4, 5, 6]
      },
      'ppvis'=> {
        'labs_count'=> 10,
        'labs'=> [2, 4, 5, 6]
      }
    },
    'start_date' => '01-09-2016',
    'finish_date' => '03-11-2016',
    'available_days' => '41',
    'reminders'=> [{
      'days'=> 1,
      'hour'=> 12
    }]
  }

  describe "check returned messages for submit class" do

    it "should return correct subject message" do
      subject = Submit.new(user)

      expect(subject.say('/submit')).to eq(Answer::WHAT_SUBJECT_PASSED(user['subjects']))
    end

    it "should return incorrect labs count message" do
      semester = Submit.new(user)
      semester.say('/submit')

      expect(semester.say('-12')).to eq(Answer::INCORRECT_LABS_COUNT)
    end

    it "should return incorrect subjects message" do
      semester = Submit.new(user)
      semester.say('/submit')
      semester.say('1')
      expect(semester.say('5')).to eq(Answer::DONT_HAVE_LABS)
    end
  end
end
