require 'colorize'

class InputParser
    attr_accessor :gname, :operators, :correct
    
    def initialize(gname, operators)
        @gname = gname 
        operators.flatten!
        operators.map! { |i| i.split }
        @operators = Hash[operators]
        @operators.keys.each do |i|
            if (i != ">" && i != "<" && i != ">=" && i != "<=" && i != "~>" && i != "<~" && i != "=" && i != "!=")
                puts 'Error aquired! Please, check your comparison operator.'.red
                exit 
            else
            end
        end
        begin
        @operators.values.map! do |i| 
            i = Gem::Version.new(i) 
        end    
        rescue ArgumentError #checks if version is formatted correctly
            puts 'Error aquired! Please, check your version formatting.'.red
            exit
        end
    end   
end
