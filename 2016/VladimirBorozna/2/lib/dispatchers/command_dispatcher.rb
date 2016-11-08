module Bot
  # Class for dispatching user commands
  class CommandDispatcher
    attr_reader :message,
                :user,
                :api

    AVAILABLE_COMMANDS = [
      Command::Start,
      Command::Semester,
      Command::Subject,
      Command::Submit,
      Command::Status,
      Command::Reset
    ].freeze

    def initialize(user, message)
      @message = message
      @user = user
      @api = Bot.configuration.api
    end

    def dispatch
      command = initialize_command
      start(command)
    rescue BotError => error
      error_message = I18n.t("errors.#{error.message}")
      api.call("sendMessage", chat_id: user.telegram_id, text: error_message)
    end

    private

    def initialize_command
      command = should_start_command || user_next_command
      return command if command

      Command::Undefined.new(user, message)
    end

    def should_start_command
      command = AVAILABLE_COMMANDS.detect do |command_class|
        command_class.new(user, message).should_start?
      end
      command&.new(user, message)
    end

    def user_next_command
      command_name = user.next_command&.name
      Object.const_get(command_name).new(user, message) if command_name
    end

    def start(command)
      if user.next_command.method
        command.public_send(user.next_command.method)
      else
        command.start
      end
      command.select_next_command
    end
  end
end
