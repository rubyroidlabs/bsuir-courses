# handle some exceptions
module RPN
  class ExceptionHandler
    def self.handle
      yield
    rescue SystemExit
      puts 'See you later =)'
    rescue TypeError
      puts 'Something went wrong (type error)'
    rescue NoMethodError
      puts 'Something went wrong (no method error)'
    end
  end
end
