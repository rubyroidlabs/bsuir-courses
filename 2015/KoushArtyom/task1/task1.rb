system "clear"

animation = []
animation[1] = %Q( (\°-°)\               ┬─┬)

animation[2] = %Q( (╯°O°)╯FUS          ┬─┬)

animation[3] = %Q( (╯°O°)╯FUS ROH      ┬─┬)

animation[4] = %Q( (╯°O°)╯FUS ROH DAH! ︵  ┻━┻)

animation[5] = %Q( (╯°O°)╯                    ┬─┬)

animation[6] = %Q( (\°-°)\                     ︵  ┻━┻)

animation[7] = %Q( (\°-°)\                            ┬─┬)

animation[8] = %Q( (\°-°)\                             ︵  ┻━┻)

animation[9] = %Q( (\°-°)\                                    ┬─┬) 

animation[10] = %Q( (\°-°)\                                     ︵  ┻━┻)

animation[11] = %Q( (\°-°)\                                            ┬─┬)

2.times do
	animation.each do |animation|
		puts animation
		sleep 0.5
		system "clear"
	end
end