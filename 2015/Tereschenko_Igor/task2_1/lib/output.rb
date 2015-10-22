require 'colorize'

class Parser
  attr_accessor :versions
  def initialize(inversions, operators)
    @versions = inversions

    begin
      @operators = operators.sort_by { |_key, value| value }
      rescue ArgumentError
        puts '(╯°□°)╯︵ ┻━┻ (invalid argumnets)'.red
        exit
      end
  end

  def match?(value)
    res1 = Array.new

    begin
      @operators.each do |k, v|
        if Gem::Dependency.new('', k + v).match?('', value)
          res1 << true
        else
          res1 << false
        end
      end
      rescue Gem::Requirement::BadRequirementError
        puts '(╯°□°)╯︵ ┻━┻ (invalid operator)'.red
        exit
      end

    if res1.include?(false)
      return false
    else
      return true
    end
  end

  def output
    @versions.each do |i|
      if match?(i) == true
        puts i.red
      else
        puts i
      end
    end
  end
end
