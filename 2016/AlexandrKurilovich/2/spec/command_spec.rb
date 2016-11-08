require_relative "../config"
redis = Redis.new(REDIS_HOST)
Telegram::Bot::Client.run(BOT_TOKEN) do |bot|
  bot.listen do |message|
    command = Command.new(bot, message, redis)
    RSpec.describe Command do
      describe "#parse_data" do
        it "returns data" do
          data = JSON.parse(redis.get(message.chat.id.to_s))
          expect(command.parse_data).to eq(data)
        end
        it "reset status" do
          command.reset_status
          data = command.parse_data
          expect([data["semester"], data["subject"]]).to eq([0, 0])
        end
      end
    end
    break
  end
end
