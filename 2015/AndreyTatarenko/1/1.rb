window_width = `/usr/bin/env tput cols`.to_i
$window_hight = `/usr/bin/env tput li`.to_i
$ruby_line = ['  _____       _                           _____       _ _',
			  			' |  __ \\     | |                         |  __ \\     (_) |',
			  			' | |__) |_  _| |__  _   _    ___  _ __   | |__) |__ _ _| |___',
			  			' |  _  / | | |  _ \\| | | |  / _ \\|  _ \\  |  _  // _  | | / __|',
			  			' | | \\ \\ |_| | |_) | |_| | | (_) | | | | | | \\ \\ (_| | | \\__ \\',
			  			' |_|  \\_\\__ _|_ __/ \\__  |  \\___/|_| |_| |_|  \\_\\__ _|_|_|___/',
			  			'                     __/ |',
			  			'                    |___/']

def next_frame
	sleep(0.05)
	system "clear"
	(($window_hight - $ruby_line.length)/2).times { |i| puts ''}
end

space_line = '';
window_width.times { space_line += ' ' }
next_frame

$ruby_line.length.times  { |i| space_line + $ruby_line[i] }

window_width.times do
	$ruby_line.length.times do |i|
		out_line = (space_line + $ruby_line[i])[0..window_width-1]
		puts out_line
	end
	space_line = space_line[1..space_line.length]
	next_frame
end

($ruby_line.max_by{ |elem| elem.size }).length.times do |i|
	$ruby_line.length.times do |j|
		out_line = $ruby_line[j][i..$ruby_line[j].length-1]
		puts out_line
	end
	next_frame
end

system "clear"