require 'telegram/bot'
require_relative 'celebrity_controller'
require_relative 'user_controller'
require_relative '../libs/transliterator_rus'
require_relative '../views/celebrity_view'
require_relative '../views/application_view'

class ApplicationController
  def initialize(token)
    @token = token
    @user_controller = UserController.new
    @celebrity_controller = CelebrityController.new
  end

  def run
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        user = identify_user(message)
        answer = process_message(message, user)
        bot.api.send_message(chat_id: message.chat.id, text: answer)
      end
    end
  end

  def process_message(message, user)
    return ApplicationView.hello if message.text == '/start'
    if user.suggested_name.nil?
      process_request(message, user)
    else
      process_answer(message, user)
    end
  end

  def process_request(message, user)
    user.search_request = message.text.from_rus_to_eng
    celebrity = @celebrity_controller.search_by_name(user.search_request)
    return ApplicationView.i_dont_know if celebrity.nil?
    if answer_correct?(celebrity['name'], message.text)
      CelebrityView.info(celebrity)
    else
      user.suggest(celebrity['name'])
      ApplicationView.first_suggestion(celebrity)
    end
  end

  def process_answer(message, user)
    case positive? message.text
    when true
      process_positive_answer(user)
    when false
      process_negative_answer(user)
    when 'stop'
      process_stop_answer(user)
    else
      ApplicationView.help
    end
  end

  def process_positive_answer(user)
    name = user.suggested_name
    celebrity = @celebrity_controller.search_by_exact_name(name)
    return out_of_suggestions(user) if celebrity.nil?
    user.suggestion_accepted
    CelebrityView.info(celebrity)
  end

  def process_negative_answer(user)
    user.suggestion_dinied
    request = user.search_request
    denied_names = user.denied_names
    celebrity = @celebrity_controller.search_by_name(request, denied_names)
    return out_of_suggestions(user) if celebrity.nil?
    user.suggest(celebrity['name'])
    ApplicationView.suggestion(celebrity)
  end

  def process_stop_answer(user)
    user.suggestion_accepted
    ApplicationView.ok
  end

  def identify_user(message)
    unless @user_controller.exist? message.chat.id
      name = "#{message.from.first_name} #{message.from.last_name}"
      @user_controller.add(message.chat.id, name)
    end
    @user_controller.users[message.chat.id]
  end

  def out_of_suggestions(user)
    user.suggestion_accepted
    ApplicationView.out_of_suggestions
  end

  def positive?(text)
    case text.downcase[0]
    when 'y', 'д'
      true
    when 'n', 'н'
      false
    when 's', 'с'
      'stop'
    else
      'undefined'
    end
  end

  def answer_correct?(found_name, requested_name)
    found_name.casecmp(requested_name).zero?
  end
end
