require_relative "../lib/parse_date"
RSpec.describe DateParser do
  describe "DateParser test" do
    it "Tests DateParser initializer" do
      date = DateParser.new("01.09.2016")
      expect(date.year).to eq(2016)
      expect(date.month).to eq(9)
      expect(date.day).to eq(1)
    end
  end
end
