require './lib/User.rb'
require 'date'
require 'rspec'
RSpec.describe User do
  describe "Start semester date test"  do
    it "check if semester start date for first semester is correct" do
      user = User.new('/start', 'Man', '2016-09-01')
      user.calculate_semester_for_first_or_second_course(Date.parse(user.start_semester))
      expect(user.start_semester).to eq '2016-09-01'
    end
    it "check if semester start date for second semester is correct" do
      user = User.new('/start', 'Man', '2017-02-03')
      user.calculate_semester_for_first_or_second_course(Date.parse(user.start_semester))
      expect(user.start_semester).to eq '2017-02-07'
    end
    it "check if semester start date for first semester is correct(third and greater)" do
      user = User.new('/start', 'Man', '2016-09-01')
      user.calculate_semester_for_third_or_greater_course(Date.parse(user.start_semester))
      expect(user.start_semester.to_s).to eq '2016-09-01'
    end
    it "check if semester start date for second semester is correct" do
      user = User.new('/start', 'Man', '2017-02-03')
      user.calculate_semester_for_first_or_second_course(Date.parse(user.start_semester))
      expect(user.start_semester).to eq '2017-02-07'
    end
  end
  describe "End semester date test"  do
    it "check if semester end date for first semester is correct" do
      user = User.new('/start', 'Man', '2016-09-01')
      user.calculate_semester_for_first_or_second_course(Date.parse(user.start_semester))
      expect(user.end_semester).to eq '2016-12-25'
    end
      it "check if semester end date for second semester is correct" do
      user = User.new('/start', 'Man', '2016-02-01')
      user.calculate_semester_for_first_or_second_course(Date.parse(user.start_semester))
      expect(user.end_semester).to eq '2017-05-31'
    end
  end
end
