#!/usr/bin/env ruby

text = ['                       *     ,MMM8&&&.            *    ',
'                            MMMM88&&&&&    .           ',
'                           MMMM88&&&&&&&               ',
'               *           MMM88&&&&&&&&               ',
'                           MMM88&&&&&&&&               ',
'                           MMM88&&&&&&&                 ',
'                             MMM8&&&&^     *            ',
'                    |\___/|                            ',
'                    )     (             .              ',
'                   =\     /=                           ',
'                     )===(       *                     ',
'                    /     \                            ',
'                    |     |                            ',
'                   /       \                           ',
'                   \       /                           ',
'            _/\_/\_/\__  _/_/\_/\_/\_/\_/\_/\_/\_/\_/\_',
'            |  |  |  |( (  |  |  |  |  |  |  |  |  |  |',
'            |  |  |  | ) ) |  |  |  |  |  |  |  |  |  |',
'            |  |  |  |(_(  |  |  |  |  |  |  |  |  |  |',
'            |  |  |  |  |  |  |  |  |  |  |  |  |  |  |',
'            |  |  |  |  |  |  |  |  |  |  |  |  |  |  |' ]

direction = 1;
5.times do
15.times do
  system 'clear'
  text.each do |string|
    puts(string)
    if (direction == 0)
       string.slice!(0)
    else
      string.insert(0, ' ')
  end
end
sleep(0.06)
end
direction ^= 1
end
