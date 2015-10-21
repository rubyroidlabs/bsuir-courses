require 'colorize'
require 'versionomy'
class Parser
    attr_accessor :versions
    def initialize (inversions, operators)
        inversions.each do |i|
            i = Versionomy.parse(i)
        end
        @versions = inversions
        @operators = operators.sort_by {|_key, value| value}
    end

    def match? (value) #lots of evil sorcery in this method 
        res1 = Array.new 
        count = 0
        @operators.each do |k, v| 
            if value.public_send(k,v)
                res1[count] = true
            else
                res1[count] = false
            end    
            count += 1
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
