#!/usr/bin/ruby
require 'io/console'
a = []
a[0] =
['```````|||```````
``````(*_*)/`````
``````/(((```````
```````//````````
`````=======`````']
a[1] =
['```````|||````````
`````\(*_*)```````
```````)))\```````
```````\\\\`````````
`````=======``````']
5.times do
  a.each do |x|
   puts x
   sleep 0.5
   system('clear')
  end
  a.reverse_each do |x|
   puts x
   sleep 0.5
   system('clear')
  end
end
