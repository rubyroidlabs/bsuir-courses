relax0 =
[ 
'     _________________________',

'       |    |    |    |    \\',

'       |    |    |    |     \\',

'       |    |    |    |      \\',

'       |    |    |    |       \\',

'      _|_  _|_  _|_  _|_      _\\_',

'     /   \\/   \\/   \\/   \\    /   \\',

'     \\___/\\___/\\___/\\___/    \\___/'
]
relax1 =
[ 
'     _________________________',

'       /    |    |    |    |',

'      /     |    |    |    |',

'     /      |    |    |    |',

'    /       |    |    |    |',

'  _/_      _|_  _|_  _|_  _|_',

' /   \\    /   \\/   \\/   \\/   \\',

' \\___/    \\___/\\___/\\___/\\___/'
]
system 'clear'
loop do
relax0.each { |i| puts i }
sleep 0.3
system 'clear' 
relax1.each { |i| puts i }
sleep 0.3
system 'clear' 	
end