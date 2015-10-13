#!/usr/local/bin/ruby

require "curses"
include Curses

pikachu = <<-FOO
    ix.                           _.;
     xxx.                      ,,xx"
     "xxb,                   .;xxxx'
      "xxxxx,              ,;xxxxx'
       "x    ',__""""""-_,;    xx'
        :   '          ."     "    
         i'                 ,^'   
        :                    ;    
        |  .-.        .-.    L     
        | ' ##'      '## '   |     
        | '###'      '###'   |     
        |        __          | 
         --               -- {
        |  |   ._--_.    |  |;
        '--'             '--',       
        '-..____________..-' 
FOO

pikachu_2 = <<-FOO
    ix.                           _.;
     xxx.                      ,,xx"
     "xxb,                   .;xxxx'
      "xxxxx,              ,;xxxxx'
       "x    ',__""""""-_,;    xx'
        :   '          ."     "    _--------------------_
         i'                 ,^'   ,'      PIKA!!          ',
        :                    ;    |      PIKACHU!!         |
        |                    L     '-.__________________.-'
        |  .-.        .--,   |      /
        | '   '      '    '  |     /
        |        __          |
         --               -- {
        |  |   ._--_.    |  |;
        '--'    `--`     '--',       
        '-..____________..-'
FOO

init_screen
x = 0
begin
    9.times do
        crmode

        y = 2
        pikachu.each_line do |row|
            setpos(y,x)
            addstr(row)
            y+=1
        end
        sleep(0.5)
        refresh
        #getch
        
        y = 2
        pikachu_2.each_line do |row|
            setpos(y,x)
            addstr(row)
            y += 1
        end
        sleep(0.5)

        
        refresh
        x += 1
    end
ensure
  close_screen
end
