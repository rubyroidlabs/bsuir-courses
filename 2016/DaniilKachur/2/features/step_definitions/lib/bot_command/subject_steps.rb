require "cucumber"
require "cucumber/rspec/doubles"
require "pry"
require "redis"
require "./lib/user"
require "./environment"
require "./telegram_bot"

Given(/^a webhook message$/) do
  @webhook_message =
    { "update_id" => 123_456_789,
      "message" =>
       { "message_id" => 1_234,
         "from" => { "id" => 123_456_789, "first_name" => "Daniil", "last_name" => "Kachur" },
         "chat" => { "id" => 123_456_789, "first_name" => "Daniil", "last_name" => "Kachur", "type" => "private" },
         "date" => 1_479_282_135,
         "text" => "/start",
         "entities" => [{ "type" => "bot_command", "offset" => 0, "length" => 6 }] } }

  @confirming_message =
    { "ok" => true,
      "result" =>
    { "message_id" => 1_234,
      "from" => { "id" => 222_222_222, "first_name" => "univeper", "username" => "univeper_bot" },
      "chat" => { "id" => 123_456_789, "first_name" => "Daniil", "last_name" => "Kachur", "type" => "private" },
      "date" => 1_479_459_062,
      "text" => "Какой-то текст" } }

  @text = "/semester"

  @webhook_message["message"]["text"] = @text
  @webhook_message["message"]["entities"][0]["length"] = @text.length
end

Given(/^a user with id ([0-9]{9})$/) do |id|
  @user = User.new(id)
end

Given(%r{^I have a message with text "(\/[a-z]*)"$}) do |command_name|
  @command_class = BotCommand::Subject if command_name == "/subject"
end

When("I try to start execute command") do
  @temp_command = @command_class.new(@user, @webhook_message)
  allow(@temp_command).to receive(:text) { "/subject" }
  @command = @temp_command if @temp_command.should_start?

  allow(@command).to receive(:send_message) do
    @confirming_message.update("result" => {}) do |_, old|
      old.update("text" => "Какой предмет учим?")
    end
  end
end

Then("Then I should update next command info") do
end

And("I should send message for response") do
  @message = @command.start
end

And(/^I should get confirming message with text "(.*)"$/) do |text|
  expect(@confirming_message["result"]["text"]).to eq(text)
end
