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
  describe "DateParser get_check test" do
  	it "Tests DateParser get_check method" do
  		date = DateParser.get_check(32, 10, 2016, "32.10.2016")
      expect(date).to eq(true)
    end
  end
  describe "DateParser labs_count test" do
  	it "Tests DateParser correct_count? method" do
  		1.upto(25) { |i| expect(DateParser.correct_count?(i)).to eq(true) }
  		expect(DateParser.correct_count?(40)).to eq(false)
  		expect(DateParser.correct_count?("двадцать три")).to eq(false)
  		expect(DateParser.correct_count?(0)).to eq(false)
    end
  end
  describe "DateParser date difference test" do
  	it "Tests DateParser day difference method" do
  		expect(DateParser.day_diff(17)).to eq("17 дней")
  		expect(DateParser.day_diff(1)).to eq("1 день")
  		expect(DateParser.day_diff(3)).to eq("3 дня")
    end
  end
    describe "DateParser date difference test" do
  	it "Tests DateParser month difference method" do
  		expect(DateParser.month_str(11)).to eq("11 месяцев")
  		expect(DateParser.month_str(1)).to eq("1 месяц")
  		expect(DateParser.month_str(3)).to eq("3 месяца")
    end
  end
end
