require_relative "../spec_helper"

describe Bot::DateParser do
  describe "#parse" do
    def parse(date)
      Bot::DateParser.parse(date)
    end

    context "correct dates" do
      it "should parse date 2016-08-02" do
        expect(parse("2016-08-02")).to eq(Date.new(2016, 8, 2))
      end

      it "should parse date 2016-08-02" do
        expect(parse("2016-08-02")).to eq(Date.new(2016, 8, 2))
      end

      it "should parse date 3000-08-02" do
        expect(parse("3000-08-02")).to eq(Date.new(3000, 8, 2))
      end

      it "should parse date 16.07.2016" do
        expect(parse("16.07.2016")).to eq(Date.new(2016, 7, 16))
      end

      it "should parse date 2020.7.1" do
        expect(parse("2020.7.1")).to eq(Date.new(2020, 7, 1))
      end

      it "should parse date 1.7.2016" do
        expect(parse("16.07.2016")).to eq(Date.new(2016, 7, 16))
      end
    end

    context "incorrect dates" do
      it "should raise an error for the 2016.13.01" do
        expect { parse("2016.13.01") }.to raise_error(Bot::BotError)
      end

      it "should raise an error for the 2015/08/02" do
        expect { parse("2015/08/02") }.to raise_error(Bot::BotError)
      end

      it "should raise an error for a string" do
        expect { parse("qwerty") }.to raise_error(Bot::BotError)
      end

      it "should raise an error for years <= 2015" do
        expect { parse("2015-08-02") }.to raise_error(Bot::BotError)
      end

      it "should raise an error for years > 3000" do
        expect { parse("3001-08-02") }.to raise_error(Bot::BotError)
      end
    end
  end
end
