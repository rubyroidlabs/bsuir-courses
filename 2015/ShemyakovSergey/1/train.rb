require 'curses'

class Image
	attr_reader :entity, :length

	def initialize entity1, entity2, entity3, entity4, entity5, entity6 
		@entity1 = entity1
		@entity2 = entity2
		@entity3 = entity3
		@entity4 = entity4
		@entity5 = entity5
		@entity6 = entity6
		@length = count_length
		@phrases = ['Look at me baby!', 'Yeah oh yeah!', 'Come on dance with me!', 'How about a dinned together?', 'You are so pretty mmm!']
	end

	def draw num, y, x, first_col = 0, last_col = @length - 1
		Curses.setpos y, x
		counter = 0
		puts num
		case num
		when 1
			@entity1.each do |str|
				if counter == 2 && x < 70 && rand(10) == 1
					temp1 = @phrases[rand(5)]
					temp = str + ' ' + temp1
					l_col = last_col + 1 + temp1.length
					Curses.addstr temp[first_col..l_col] if first_col < temp.length
				 	Curses.setpos y += 1, x
				 	counter += 1
				else
					Curses.addstr str[first_col..last_col] if first_col < str.length
				 	Curses.setpos y += 1, x
				 	counter += 1
				end 	
			end
		when 2
			@entity2.each do |str|
				if counter == 2 && x < 70 && rand(10) == 1
					temp1 = @phrases[rand(5)]
					temp = str + ' ' + temp1
					l_col = last_col + 1 + temp1.length
					Curses.addstr temp[first_col..l_col] if first_col < temp.length
				 	Curses.setpos y += 1, x
				 	counter += 1
				else
					Curses.addstr str[first_col..last_col] if first_col < str.length
				 	Curses.setpos y += 1, x
				 	counter += 1
				end 	
			end
		when 3
			@entity3.each do |str|
				if counter == 2 && x < 70 && rand(10) == 1
					temp1 = @phrases[rand(5)]
					temp = str + ' ' + temp1
					l_col = last_col + 1 + temp1.length
					Curses.addstr temp[first_col..l_col] if first_col < temp.length
				 	Curses.setpos y += 1, x
				 	counter += 1
				else
					Curses.addstr str[first_col..last_col] if first_col < str.length
				 	Curses.setpos y += 1, x
				 	counter += 1
				end 	
			end	
		when 4
			@entity4.each do |str|
				if counter == 2 && x < 70 && rand(10) == 1
					temp1 = @phrases[rand(5)]
					temp = str + ' ' + temp1
					l_col = last_col + 1 + temp1.length
					Curses.addstr temp[first_col..l_col] if first_col < temp.length
				 	Curses.setpos y += 1, x
				 	counter += 1
				else
					Curses.addstr str[first_col..last_col] if first_col < str.length
				 	Curses.setpos y += 1, x
				 	counter += 1
				end 	
			end	
		when 5
			@entity5.each do |str|
				if counter == 2 && x < 70 && rand(10) == 1
					temp1 = @phrases[rand(5)]
					temp = str + ' ' + temp1
					l_col = last_col + 1 + temp1.length
					Curses.addstr temp[first_col..l_col] if first_col < temp.length
				 	Curses.setpos y += 1, x
				 	counter += 1
				else
					Curses.addstr str[first_col..last_col] if first_col < str.length
				 	Curses.setpos y += 1, x
				 	counter += 1
				end 	
			end	
		when 6
			@entity6.each do |str|
				if counter == 2 && x < 70 && rand(10) == 1
					temp1 = @phrases[rand(5)]
					temp = str + ' ' + temp1
					l_col = last_col + 1 + temp1.length
					Curses.addstr temp[first_col..l_col] if first_col < temp.length
				 	Curses.setpos y += 1, x
				 	counter += 1
				else
					Curses.addstr str[first_col..last_col] if first_col < str.length
				 	Curses.setpos y += 1, x
				 	counter += 1
				end 	
			end	
		end	
		Curses.refresh		
	end

	def move
		max_x = Curses.cols - 1
		x = 0
		y = 0
		num = 1
		upto = true
		while x < max_x
			if x >= 0
				self.draw num, y, x, 0, max_x - x
			else
				self.draw num, y, 0, -x, max_x
			end
			x += 1
			sleep(0.05)
			self.edit_entity if x % 8 == 0
			Curses.clear
			if upto && num != 6
				num += 1
			elsif upto && num == 6
				upto = false;
				num -= 1
			elsif !upto && num != 1
				num -= 1
			elsif !upto && num == 1
				upto = true
				num += 1
			end				
		end
	end

private

	def count_length
		max_length = 0
		@entity1.each { |str| max_length = str.length if str.length > max_length}
			max_length
		end
	end


Curses.init_screen
Curses.curs_set 0

cherry_entity1 = [
'                    .v2@SPk7                 ',       
'                  ,Bj.     i05               ',     
'                 rB   0   0  iB              ',       
'                 B.  _  W  _  @B             ',       
'        rUS@@@B@B@@,  =====   B@::           ',       
'      @B:          B@       :@r :iuB:        ',       
'      B     ,i:r   .B     i@1      .B        ',       
'      @   @u;.uB         0u.       v@        ',       
'      B  PB   7@           ujii@j i1         ',       
'      @  i@   @7           B,  B  @          ',       
'      B   B   BY           @B @@ .@2BXr      ',       
'    @B@,  @.  LB            @:@,      @B     ',       
'  7@      B1   @             @Br      ;@     ',       
'  LB.    .@,   @@             jBY:ivuB@      ',       
'   v@B@@u      BL             .B@,           ',       
'                Bj              i@.          ',       
'                 ;@:              @B.        ',      
'                   @B,              B@       ',       
'                     B@.       BS    v@.     ',       
'                       @@       L@     @     ',      
'                        .@i      i@     @    ',       
'                          B       B7    @    ',       
'                          @       @,    @    ',       
'                         iB      vj    i@    ',       
'                        vB      @B    .B     ',      
'                       @@      @B     @:     ',     
'                     r@r      @7    :B:      ',    
'                    @S      v@     2B        ',   
'                  rB.      B@     @N         ',  
'                 :B     ,LB.    7@           ',       
'                 Uu     LB:    :@B           ',      
'                  Bi      uL     vB          ',       
'                   B@,     Bi    :@          ',       
'                     5@k:  @BXSNB5           ',       
'                        7L:                  ',       
]	

cherry_entity2 = [
'                    .v2@SPk7                 ',       
'                  ,Bj.     i05               ',     
'                 rB   0   0  iB              ',       
'                 B.  _  W  _  @B             ',       
'        rUS@@@B@B@@,  =====   B@::           ',       
'      @B:          B@       :@r :iuB:        ',       
'      B     ,i:r   .B     i@1      .B        ',       
'      @   @u;.uB         0u.       v@        ',       
'      B  PB   7@           ujii@j i1         ',       
'      @  i@   @7           B,  B  @          ',       
'      B   B   BY           @B @@ .@2BXr      ',       
'    @B@,  @.  LB            @:@,      @B     ',       
'  7@      B1   @             @Br      ;@     ',       
'  LB.    .@,   @@             jBY:ivuB@      ',       
'   v@B@@u      BL             .B@,           ',       
'                Bj              i@.          ',       
'                ;@:              @B.         ',      
'                  @B,              B@        ',       
'                    B@.       BS    v@.      ',       
'                      @@       L@     @      ',      
'                       .@i      i@     @     ',       
'                         B       B7    @     ',       
'                         @       @,    @     ',       
'                        iB      vj    i@     ',       
'                       vB      @B    .B      ',      
'                      @@      @B     @:      ',     
'                    r@r      @7    :B:       ',    
'                   @S      v@     2B         ',   
'                 rB.      B@     @N          ',  
'                :B     ,LB.    7@            ',       
'                Uu     LB:    :@B            ',      
'                 Bi      uL     vB           ',       
'                  B@,     Bi    :@           ',       
'                    5@k:  @BXSNB5            ',       
'                       7L:                   ',       
]	

cherry_entity3 = [
'                    .v2@SPk7                 ',       
'                  ,Bj.     i05               ',     
'                 rB   0   0  iB              ',       
'                 B.  _  W  _  @B             ',       
'        rUS@@@B@B@@,  =====   B@::           ',       
'      @B:          B@       :@r :iuB:        ',       
'      B     ,i:r   .B     i@1      .B        ',       
'      @   @u;.uB         0u.       v@        ',       
'      B  PB   7@           ujii@j i1         ',       
'      @  i@   @7           B,  B  @          ',       
'      B   B   BY           @B @@ .@2BXr      ',       
'    @B@,  @.  LB            @:@,      @B     ',       
'  7@      B1   @             @Br      ;@     ',       
'  LB.    .@,   @@             jBY:ivuB@      ',       
'   v@B@@u      BL             .B@,           ',       
'                Bj              i@.          ',       
'                ;@:              @B.         ',      
'                  @B,              B@        ',       
'                   B@.       BS    v@.       ',       
'                     @@       L@     @       ',      
'                      .@i      i@     @      ',       
'                        B       B7    @      ',       
'                        @       @,    @      ',       
'                       iB      vj    i@      ',       
'                      vB      @B    .B       ',      
'                     @@      @B     @:       ',     
'                   r@r      @7    :B:        ',    
'                  @S      v@     2B          ',   
'                 rB.      B@     @N          ',  
'                :B     ,LB.    7@            ',       
'                Uu     LB:    :@B            ',      
'                 Bi      uL     vB           ',       
'                  B@,     Bi    :@           ',       
'                    5@k:  @BXSNB5            ',       
'                       7L:                   ',       
]

cherry_entity4 = [
'                    .v2@SPk7                 ',       
'                  ,Bj.     i05               ',     
'                 rB   0   0  iB              ',       
'                 B.  _  W  _  @B             ',       
'        rUS@@@B@B@@,  =====   B@::           ',       
'      @B:          B@       :@r :iuB:        ',       
'      B     ,i:r   .B     i@1      .B        ',       
'      @   @u;.uB         0u.       v@        ',       
'      B  PB   7@           ujii@j i1         ',       
'      @  i@   @7           B,  B  @          ',       
'      B   B   BY           @B @@ .@2BXr      ',       
'    @B@,  @.  LB            @:@,      @B     ',       
'  7@      B1   @             @Br      ;@     ',       
'  LB.    .@,   @@             jBY:ivuB@      ',       
'   v@B@@u      BL             .B@,           ',       
'                Bj              i@.          ',       
'                ;@:              @B.         ',      
'                  @B,              B@        ',       
'                   B@.       BS    v@.       ',       
'                    @@       L@     @        ',      
'                     .@i      i@     @       ',       
'                       B       B7    @       ',       
'                       @       @,    @       ',       
'                      iB      vj    i@       ',       
'                     vB      @B    .B        ',      
'                     @@      @B     @:       ',     
'                   r@r      @7    :B:        ',    
'                  @S      v@     2B          ',   
'                 rB.      B@     @N          ',  
'                :B     ,LB.    7@            ',       
'                Uu     LB:    :@B            ',      
'                 Bi      uL     vB           ',       
'                  B@,     Bi    :@           ',       
'                    5@k:  @BXSNB5            ',       
'                       7L:                   ',       
]

cherry_entity5 = [
'                    .v2@SPk7                 ',       
'                  ,Bj.     i05               ',     
'                 rB   0   0  iB              ',       
'                 B.  _  W  _  @B             ',       
'        rUS@@@B@B@@,  =====   B@::           ',       
'      @B:          B@       :@r :iuB:        ',       
'      B     ,i:r   .B     i@1      .B        ',       
'      @   @u;.uB         0u.       v@        ',       
'      B  PB   7@           ujii@j i1         ',       
'      @  i@   @7           B,  B  @          ',       
'      B   B   BY           @B @@ .@2BXr      ',       
'    @B@,  @.  LB            @:@,      @B     ',       
'  7@      B1   @             @Br      ;@     ',       
'  LB.    .@,   @@             jBY:ivuB@      ',       
'   v@B@@u      BL             .B@,           ',       
'                Bj              i@.          ',       
'                ;@:              @B.         ',      
'                  @B,              B@        ',       
'                   B@.       BS    v@.       ',       
'                    @@       L@     @        ',      
'                    .@i      i@      @       ',       
'                      B       B7     @       ',       
'                      @       @,     @       ',       
'                     iB      vj     i@       ',       
'                     vB      @B    .B        ',      
'                    @@      @B     @:       ',     
'                   r@r      @7    :B:        ',    
'                  @S      v@     2B          ',   
'                 rB.      B@     @N          ',  
'                :B     ,LB.    7@            ',       
'                Uu     LB:    :@B            ',      
'                 Bi      uL     vB           ',       
'                  B@,     Bi    :@           ',       
'                    5@k:  @BXSNB5            ',       
'                       7L:                   ',       
]

cherry_entity6 = [
'                    .v2@SPk7                 ',       
'                  ,Bj.     i05               ',     
'                 rB   0   0  iB              ',       
'                 B.  _  W  _  @B             ',       
'        rUS@@@B@B@@,  =====   B@::           ',       
'      @B:          B@       :@r :iuB:        ',       
'      B     ,i:r   .B     i@1      .B        ',       
'      @   @u;.uB         0u.       v@        ',       
'      B  PB   7@           ujii@j i1         ',       
'      @  i@   @7           B,  B  @          ',       
'      B   B   BY           @B @@ .@2BXr      ',       
'    @B@,  @.  LB            @:@,      @B     ',       
'  7@      B1   @             @Br      ;@     ',       
'  LB.    .@,   @@             jBY:ivuB@      ',       
'   v@B@@u      BL             .B@,           ',       
'                Bj              i@.          ',       
'                ;@:              @B.         ',      
'                  @B,              B@        ',       
'                   B@.       BS    v@.       ',       
'                    @@       L@     @        ',      
'                   .@i      i@      @        ',       
'                     B       B7      L       ',       
'                     @       @,      @       ',       
'                    iB      vj      i@       ',       
'                    vB      @B     .B        ',      
'                    @@      @B     @:        ',     
'                   r@r      @7    :B:        ',    
'                  @S      v@     2B          ',   
'                 rB.      B@     @N          ',  
'                :B     ,LB.    7@            ',       
'                Uu     LB:    :@B            ',      
'                 Bi      uL     vB           ',       
'                  B@,     Bi    :@           ',       
'                    5@k:  @BXSNB5            ',       
'                       7L:                   ',       
]

cherry = Image.new cherry_entity1, cherry_entity2, cherry_entity3, cherry_entity4, cherry_entity5, cherry_entity6
class << cherry
  def edit_entity
    @entity1.each do |str|
      if str['@']
        str.gsub! '@', '*'
      else
        str.gsub! '*', '@'
      end
    end
    @entity2.each do |str|
      if str['@']
        str.gsub! '@', '*'
      else
        str.gsub! '*', '@'
      end
    end
    @entity3.each do |str|
      if str['@']
        str.gsub! '@', '*'
      else
        str.gsub! '*', '@'
      end
    end
    @entity4.each do |str|
      if str['@']
        str.gsub! '@', '*'
      else
        str.gsub! '*', '@'
      end
    end
    @entity5.each do |str|
      if str['@']
        str.gsub! '@', '*'
      else
        str.gsub! '*', '@'
      end
    @entity6.each do |str|
      if str['@']
        str.gsub! '@', '*'
      else
        str.gsub! '*', '@'
      end
    end
    end
  end
end
cherry.move
Curses.close_screen
