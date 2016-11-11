module Bot
  # Class for dispatching user commands
  class CommandDispatcher < Dispatcher
    attr_reader :message, :command, :next_command

    AVAILABLE_COMMANDS = [
      Command::Start,
      Command::Semester,
      Command::Subject,
      Command::Status,
      Command::Submit,
      Command::Cancel,
      Command::Remind,
      Command::Reset
    ].freeze

    def initialize(api, user, message)
      super(api, user)
      @message = message
      @next_command = user.next_command
      @command = command_instance
    end

    def dispatch
      process
    rescue BotError => error
      error_message = translate_error(error.message)
      api.call("sendMessage", chat_id: user.telegram_id, text: error_message)
    end

    private

    def process
      method = next_command&.method
      if method && !command.is_a?(Command::Cancel)
        command.public_send(method)
      else
        command.start
      end
      command.set_next_method
    end

    def command_instance
      should_start_command || user_next_command || undefined_command
    end

    def should_start_command
      cmd = AVAILABLE_COMMANDS.detect do |cmd_class|
        cmd_class.new(api, user, message).should_start?
      end
      cmd&.new(api, user, message)
    end

    def user_next_command
      cmd_name = next_command&.name
      Object.const_get(cmd_name).new(api, user, message) if cmd_name
    end

    def undefined_command
      Command::Undefined.new(api, user, message)
    end
  end
end
