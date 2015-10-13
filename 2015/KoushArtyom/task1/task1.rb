system 'clear'
animation = []
animation[1] = %q( (\°-°)\               ┬─┬)
animation[2] = %q( (╯°O°)╯FUS          ┬─┬)
animation[3] = %q( (╯°O°)╯FUS ROH      ┬─┬)
animation[4] = %q( (╯°O°)╯FUS ROH DAH! ︵  ┻━┻)
animation[5] = %q( (╯°O°)╯                    ┬─┬)
animation[6] = %q( (\°-°)\                     ︵  ┻━┻)
animation[7] = %q( (\°-°)\                            ┬─┬)
animation[8] = %q( (\°-°)\                             ︵  ┻━┻)
animation[9] = %q( (\°-°)\                                    ┬─┬) 
animation[10] = %q( (\°-°)\                                     ︵  ┻━┻)
animation[11] = %q( (\°-°)\                                            ┬─┬)
2.times do
	animation.each do |animation|
		puts animation
		sleep 0.5
		system 'clear'
	end
end