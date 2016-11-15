Given(/^text "([^\"]*)"$/) do |text|
  p text
end

Then(/^start execution of (BotCommand::Semester)$/) do |command_class|
  p command_class
end

And(/^view message "([^\"]*)"$/) do |message|
  p message
end
