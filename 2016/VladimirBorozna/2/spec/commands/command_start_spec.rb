require_relative "../spec_helper"

describe Bot::Command::Start do
  describe "#start" do
    def api
      Bot.configuration.api
    end

    it "should make a request", vcr: { record: :once } do
      user = build(:user)
      response = Bot::Command::Start.new(api, user, nil).start

      expect(response["result"]["chat"]["id"]).to eq(user.telegram_id)
      expect(response["ok"]).to eq(true)
    end
  end
end
