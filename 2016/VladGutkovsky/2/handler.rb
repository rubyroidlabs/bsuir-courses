require 'telegram/bot'

require_relative 'session'

# base event handler class
class Handler
  def equals?(_message)
    raise NotImplementedError
  end

  def ==(other)
    equals? other
  end

  def handle(from, message)
    answer from, message
  end

  def answer(_from, _message)
    raise NotImplementedError
  end
end

# chain dialog handler class
class ChainHandler < Handler
  def ==(other)
    equals?(other) || (
      !Session.get('__promt__').nil? && !@monitored_vars.index do |v|
        v.match(Session.get('__promt__'))
      end.nil?
    )
  end

  def handle(from, message)
    if !Session.get('__promt__').nil? && !@monitored_vars.index do |v|
      v.match(Session.get('__promt__'))
    end.nil?
      handle_var from, Session.get('__promt__'), message
    else
      answer from, message
    end
  end

  def handle_var(_from, _key, _value)
    raise NotImplementedError
  end
end
