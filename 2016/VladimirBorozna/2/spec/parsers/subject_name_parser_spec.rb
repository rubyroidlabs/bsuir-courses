require_relative "../spec_helper"

describe Bot::SubjectNameParser do
  describe "#parse" do
    def parse(date)
      Bot::SubjectNameParser.parse(date)
    end

    context "correct subject names" do
      it "should parse ОАиП" do
        expect(parse("ОАиП")).to eq("ОАиП")
      end

      it "should parse НПО" do
        expect(parse("НПО")).to eq("НПО")
      end

      it "should parse ТИ" do
        expect(parse("ТИ")).to eq("ТИ")
      end

      it "should parse name with length == 20" do
        subject_name = "QWERTYUIOPASDFGHJKLZ"
        expect(2..20).to cover(subject_name.length)
        expect { parse(subject_name) }.to raise_error(Bot::BotError)
      end
    end

    context "incorrect name" do
      it "should raise an error for name with length == 1" do
        expect { parse("A") }.to raise_error(Bot::BotError)
      end

      it "should raise an error for name with length > 20" do
        subject_name = "QWERTYUIOPASDFGHJKLZX"
        expect(subject_name.length).to be > 20
        expect { parse(subject_name) }.to raise_error(Bot::BotError)
      end
    end
  end
end
