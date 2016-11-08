require_relative '../config'
redis = Redis.new(REDIS_HOST)
Telegram::Bot::Client.run(BOT_TOKEN) do |bot|
  bot.listen do |message|
    RSpec.describe Command do
      describe "#parse_data" do
        it "returns data" do
          command = Command.new(bot, message, redis)
          data = JSON.parse(redis.get(message.chat.id.to_s))
          expect(command.parse_data).to eq(data)
        end
      end
    end
    break
  end
end
