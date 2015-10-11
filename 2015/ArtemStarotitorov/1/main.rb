#!/usr/bin/env ruby

NUMBER_OF_ROW_WITH_PATRON = 1
NUMBER_OF_COLUMN_WITH_PATRON = 26

class Gun

    def initialize
        @@count_of_iterations = 45
        @file = File.open("gun.txt")
        @picture = @file.to_a
        @file.close
    end

    def shot
        @@count_of_iterations.times do |i|
            system "clear"
            @picture[NUMBER_OF_ROW_WITH_PATRON].
            insert(NUMBER_OF_COLUMN_WITH_PATRON, ' ')
            puts @picture
            sleep 0.02
        end
    end
end

gun = Gun.new.shot
