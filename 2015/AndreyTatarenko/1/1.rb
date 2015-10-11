#!/usr/bin/env ruby

window_width = `/usr/bin/env tput cols`.to_i
$window_hight = `/usr/bin/env tput li`.to_i
$RUBY_LINE = [	"  _____       _                           _____       _ _",
			 	" |  __ \\     | |                         |  __ \\     (_) |",
			 	" | |__) |   _| |__  _   _    ___  _ __   | |__) |__ _ _| |___",
			 	" |  _  / | | | '_ \\| | | |  / _ \\| '_ \\  |  _  // _` | | / __|",
			 	" | | \\ \\ |_| | |_) | |_| | | (_) | | | | | | \\ \\ (_| | | \\__ \\",
			 	" |_|  \\_\\__,_|_.__/ \\__, |  \\___/|_| |_| |_|  \\_\\__,_|_|_|___/",
				"                     __/ |",
				"                    |___/"]

def next_frame()
	sleep(0.05)
	system "clear"
	(($window_hight-$RUBY_LINE.length)/2).times { |i| puts ""  }
end

space_quant = window_width

next_frame()

window_width.times do
	$RUBY_LINE.length.times do |i|
		out_line = "";
		space_quant.downto(0) { out_line = out_line + " "}
		out_line = (out_line + $RUBY_LINE[i])[0..window_width-1]
		puts out_line
	end
	space_quant -= 1
	next_frame()	
end

$RUBY_LINE.max_by{ |elem| elem.size }.length.times do |i|
	$RUBY_LINE.length.times do |j|
		out_line = $RUBY_LINE[j][i..$RUBY_LINE[j].length-1]
		puts out_line
	end
	next_frame()
end

system "clear"