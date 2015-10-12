class Task001

	def initialize

		@lisa ="        o8%8888,    
       o88%8888888.  
      8'-    -:8888b   
     8'         8888  
    d8.-=. ,==-.:888b  
    >8 `~` :`~' d8888   
    88         ,88888   
    88b. `-~  ':88888  
    888b ~==~ .:88888 
    88888o--:':::8888      
    `88888| :::' 8888b  
    8888^^'       8888b  
   d888           ,%888b.   
  d88%            %%%8--'-.  
 /88:.__ ,       _%-' ---  -  
     '''::///..-'    --.  "

		@message  = "
Why does the Mona Lisa smile? Because she's laughing inside 
at all the garbage that is reported about her.
It is time to tell some home truths about the Leonardo da Vinci
industry. This great artist really deserves better than the media 
circus of pseudoscience and hocus pocus that surrounds his art. 
No genius merits closer attention from today's world than 
Leonardo. His mind, as revealed in his notebooks,
 is a source of endless fascination, 
 just as his few surviving paintings are 
 infinitely enigmatic. 
 But instead of stories or interpretations that enrich our 
 understanding of Leonardo, the world media delights in 
 endless tittle-tattle and nonsense that just makes his 
 art less meaningful, and reduces him to a bearded magus 
 who painted empty icons.
"
	end

	def show(seconds)
		i = 0
		(seconds * 10).times do 
			@lisa.each_char do 
				|s| 
				print '-' if s == '=' 
				print s unless s == '='
			end
			#fixing output
			puts " "
			puts @message[0..i]
			sleep(0.1)
			system "clear"

			puts @lisa
			puts @message[0..i]
			sleep(0.1)
			system "clear"

			i += 1
		end
	end
end 

sl_killer = Task001.new
sl_killer.show(10)