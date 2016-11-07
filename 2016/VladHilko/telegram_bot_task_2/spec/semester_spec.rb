require_relative '../lib/base'
require_relative '../lib/semester'
require 'redis'
require 'telegram/bot'
require 'date'

token = '274685898:AAEuPrF8KsgxHyenEt_OGEOO8PGdP2lPTIM'

RSpec.describe Semester do
  let(:token) { '274685898:AAEuPrF8KsgxHyenEt_OGEOO8PGdP2lPTIM' }
  let(:user_id) { 178_107_947 }

  let(:bot_one) do
    Telegram::Bot::Client.run(token) do |bot|
      bot
    end
  end

  before(:each) do
    if bot_one.api.getUpdates['result'].empty?
      bot_one.api.sendMessage(chat_id: user_id, text: 'Введи соообщение для начала работы тестов: ')
    end
    @semester = Semester.new(bot_one, user_id)
  end

  context "When testing the Semester class" do
    it "should check number of argement when create Semester class" do
      expect { Semester.new }.to raise_error(ArgumentError)
    end

    it "should raise NoMethodError exceptions " do
      bot = 'effefefeffe'
      expect { Semester.new(bot, user_id) }.to raise_error(NoMethodError)
    end

    it "user_id should be eql" do
      expect(@semester.user_id).to eq user_id
    end

    it "should be respond date_day_difference method " do
      expect(@semester).to respond_to(:date_day_difference)
    end

    it "should be correct date value" do
      date1 = '12.12.2005'
      expect(@semester.str_date?(date1)).to be true
    end

    it "should be incorrect date value" do
      date1 = '12dwad.daw12.ef2005'
      expect(@semester.str_date?(date1)).to be false
    end
  end
end
