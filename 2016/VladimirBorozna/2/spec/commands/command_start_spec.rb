require_relative "../spec_helper"
require "json"

describe "Command::Start" do
  describe ".start" do
    let(:request) { recorded_request("start") }

    def user
      double(
        "user",
        telegram_id: 293_410_157,
        next_command: nil
      )
    end

    def update
      json_data = JSON.parse(request.body.string)
      Telegram::Bot::Types::Update.new(json_data)
    end

    it "should make a request", vcr: { record: :once } do
      response = Bot::Command::Start.new(user, update).start

      expect(response["result"]["chat"]["id"]).to eq(user.telegram_id)
      expect(response["ok"]).to eq(true)
    end
  end
end
