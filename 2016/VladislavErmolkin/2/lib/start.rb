require_relative 'action'

class Start < Action
    def initialize(name)
      super(nil, '')
      @name = ', ' + name
    end

    def run
        return "Hi#{@name}. 
    Honestly, I don't feel enthusiastic about doing smth.
    But I'm just a bot and have no choise. 
    So it's list of tasks I can take:
    /start
    /semester
    /subject
    /status
    /reset"
    end
end