system ("clear")
puts ("\n")*20
var1 = 30
a = "++++  +      + ++++  +      + \n"
b = "+   + +      + +   +  +    +  \n"
c = "+  +  +      + +   +   +  +   \n"
d = "++    +      + ++++     ++    \n"
e = "+ +   +      + +   +    ++    \n"
f = "+  +   +    +  +   +    ++    \n"
g = "+   +    ++    ++++     ++    \n"
loop do 
if var1 < 80
var1 += 1
print a.rjust(var1), b.rjust(var1), c.rjust(var1), d.rjust(var1),e.rjust(var1), f.rjust(var1), g.rjust(var1)
sleep (0.1)
system ("clear")
puts ("\n")*10
else 
var1 -=50
end
end