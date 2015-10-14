system 'clear'

animation = []

animation[1] = '(\°-°)\               ┬─┬'
animation[2] = '(╯°O°)╯FUS          ┬─┬'
animation[3] = '(╯°O°)╯FUS ROH      ┬─┬'
animation[4] = '(╯°O°)╯FUS ROH DAH! ︵  ┻━┻'
animation[5] = '(╯°O°)╯                    ┬─┬'
animation[6] = '(\°-°)\                     ︵  ┻━┻'
animation[7] = '(\°-°)\                            ┬─┬'
animation[8] = '(\°-°)\                             ︵  ┻━┻'
animation[9] = '(\°-°)\                                    ┬─┬'
animation[10] = '(\°-°)\                                     ︵  ┻━┻'
animation[11] = '(\°-°)\                                            ┬─┬'

2.times do
	animation.each do |anim|
		puts anim
		sleep 0.5
		system 'clear'
	end
end
