require_relative "config"
redis = Redis.new(REDIS_HOST)
Telegram::Bot::Client.run(BOT_TOKEN) do |bot|
  bot.listen do |message|
    start_bot = Start.new(bot, message, redis)
    semester_bot = Semester.new(bot, message, redis)
    subject_bot = Subject.new(bot, message, redis)
    status_bot = Status.new(bot, message, redis)
    reset_bot = Reset.new(bot, message, redis)
    case message.text
    when '/start'
      start_bot.message
    when '/semester'
      semester_bot.message
    when '/subject'
      subject_bot.message
    when '/status'
      status_bot.message
    when '/reset'
      reset_bot.message
    else
      semester_bot.handler
      subject_bot.handler
    end
  end
end
