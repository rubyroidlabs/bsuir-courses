require 'colorize'
require 'versionomy'

class Parser
    attr_accessor :versions
    def initialize(inversions, operators)
        inversions.each do |i|
            i = Versionomy.parse(i)
        end
        @versions = inversions
        @operators = operators.sort_by { |_key, value| value }
    end

    def match? (value) 
        res1 = Array.new
        @operators.each do |k, v|
            if Gem::Dependency.new('', k + v).match?('', value)
                res1 << true
            else
                res1 << false
            end
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
