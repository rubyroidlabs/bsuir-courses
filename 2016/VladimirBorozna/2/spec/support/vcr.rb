VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<TELEGRAM_BOT_TOKEN>") do
    Bot.configuration.bot_token
  end
end

RSpec.configure do |config|
  config.mock_with :rspec

  config.around(:each) do |example|
    options = example.metadata[:vcr] || {}
    if options[:record] == :skip
      VCR.turned_off(&example)
    else
      name = example.
             metadata[:full_description].
             split(/\s+/, 2).
             join("/").tr(".", "/").
             gsub(%r{[^\w\/]+}, "_").
             gsub(%r{\/$}, "").
             downcase
      VCR.use_cassette(name, options, &example)
    end
  end
end
