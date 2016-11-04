require './lib/User.rb'
require 'date'
RSpec.describe User, "#start_semester" do
  context "no date input" do
    it "check if date is correct" do
      user = User.new('/start', 'Man', '2016-09-01')
      user.calculate_semester_for_first_or_second_course(Date.parse(user.start_semester))
      expect(user.start_semester).to eq '2016-09-01'
    end
  end
end
