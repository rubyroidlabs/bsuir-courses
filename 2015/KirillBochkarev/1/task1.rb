im1 = []

im1[0] = '~~~~~~~~~~~~~~|---------   '
im1[1] = '~~~~~~~~~~~~~~|  |--|      '
im1[2] = '~~~~~~~~~~~~~~| _|--|--    '
im1[3] = '~~~~~~~~~~~~~~|()______()  '
im1[4] = '~~~~~~~~~~~~~~|---------   '

im2 = []

im2[0] = '~~~~~~~~~~~~~~|---------   '
im2[1] = '~~~~~~~~~~~~~~|  |--|      '
im2[2] = '~~~~~~~~~~~~~~| _|--|--    '
im2[3] = '~~~~~~~~~~~~~~|o______o    '
im2[4] = '~~~~~~~~~~~~~~|---------   '

dig = 0

loop do
    dig += 1
    if dig % 2 == 0
    	puts im1
    	im1.map! do |a|
    		" " + a
    	end
    else
    	puts im2
    	im2.map! do |a|
    		" " + a
    	end
    end
    sleep (0.05)
    system 'clear'
end
