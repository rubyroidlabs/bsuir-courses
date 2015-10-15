require 'io/console'
animation =
%[`````````````````````````/\\``````````/\,
`````````````````````````(`\\````````//`),
``````````````````````````\`\\``````//`/,
```````````````````````````\_\\||||//_/`,
````````````````````````````\/`_``_`\`,
```````````````````````````\/|(O)(O)|,
``````````````````````````\/`|``````|,
``````_DMITRIY_SOPOT_____\/``\\``````/,
`````//````````````````//`````|____|,
````//````````````````||`````/``````\,
```//|````````````````\|`````\\`0``0`/,
``//`\```````)`````````V````/`\\____/`,
`//```\`````/````````(`````/,
""`````\```/_________|``|_/,
```````/``/\```/`````|``||,
``````/``/`/``/``````\``||,
``````|`|``|`|````````|`||,
``````|`|``|`|````````|`||,
``````|_|``|_|````````|_||,
```````\_\``\_\````````\_\\].split

  winsize = IO.console.winsize

  animation_length = animation.min.length

  limit_size = winsize[1] - winsize[1] % animation_length
  def sleep_and_clear
    sleep 0.06
   system 'clear'
  end
  loop do|a|
  animation_length.upto(limit_size) do |b|
  animation.map! {|e| e.rjust(e.length + 1)}
  sleep_and_clear
  puts animation
  end
  limit_size.downto(animation_length) do |c|
    animation.map! {  |e| e.slice!(1..-1)  }
    sleep_and_clear
   puts animation
   end
   end
